#!/bin/env python3
import asyncio
import json
from os.path import isfile
from dataclasses import dataclass
from collections import defaultdict
from typing import Iterable
from pathlib import Path


class ParallelScriptRunner:
    def __init__(self, unordered_scripts: Iterable[str | Path]) -> None:
        self.unordered_scripts: list[str] = list(
            map(lambda s: str(s), unordered_scripts)
        )
        self.subprocesses: list = []

    def is_empty(self) -> bool:
        return len(self.unordered_scripts) <= 0

    def add_script(self, script: str | Path) -> None:
        self.unordered_scripts.append(str(script))

    def add_scripts(self, scripts: list[str | Path]) -> None:
        self.unordered_scripts += list(map(lambda s: str(s), scripts))

    def check(self) -> bool:
        return all(map(lambda script: isfile(script), self.unordered_scripts))

    async def run(self) -> None:
        async def create_subproc(s) -> None:
            proc = await asyncio.create_subprocess_exec(
                f"./{s}",
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
            )
            stdout, stderr = await proc.communicate()
            print(f"[{s!r} exited with {proc.returncode}]")
            if stdout:
                print(f"[stdout]\n{stdout.decode()}")
            if stderr:
                print(f"[stderr]\n{stderr.decode()}")

        coros = [create_subproc(script) for script in self.unordered_scripts]
        await asyncio.gather(*coros)


@dataclass
class DepSpec:
    deps: set[str]
    ordered_scripts: list[str | Path]
    apt_install: list[str]


class DepManager:
    def __init__(self) -> None:
        self.specs: dict[str, DepSpec] = {}
        self.columns: dict[str, int] = {}  # Using dict as an ordered set
        self.columns_rev: dict[int, list[str]] = {}

    def add_spec(self, path: Path) -> None:
        assert path != None
        with open(path, "r") as f:
            spec = json.load(f)
            self.specs[str(path.with_suffix(""))] = DepSpec(**spec)

    def handle_dep(self, dep_name: str, depth: int, dispatcher_stack: set[str]) -> int:
        print(
            f"HANDLING dep: {dep_name} (depth: {depth} | dispatcher stack: {dispatcher_stack})"
        )
        if dep_name in dispatcher_stack:
            raise RecursionError(f"Error: dependency loop detected: `{dep_name}`")
        if dep_name in self.columns:
            print(f"CACHED dep: {dep_name} (requested by: {dispatcher_stack})")
            return self.columns.get(dep_name, -1)

        spec = self.specs.get(dep_name)
        if spec is None:
            print(f"Warning: {spec} spec does not exist!")
            return depth
        for dep in spec.deps:
            dep_spec = self.specs.get(dep)
            if dep_spec is None:
                print(f"Warning: {dep} dep does not exist!")
                continue
            depth = max(
                self.handle_dep(dep, depth, {dep_name} | dispatcher_stack) + 1, depth
            )
        print(f"ADDING dep: {dep_name} (depth: {depth})")
        self.columns[dep_name] = depth

        return depth

    def manage(self) -> None:
        return self.manage_some(self.specs.keys())

    def manage_some(self, some: Iterable[str]) -> None:
        for dep in some:
            self.handle_dep(dep, 0, set())
        columns_rev: defaultdict[int, list[str]] = defaultdict(list)
        for dep, depth in self.columns.items():
            columns_rev[depth].append(dep)
        self.columns_rev = dict(columns_rev)
        print(self.columns_rev)

        print("Resolving dependency scripts...")
        pscript_runners: list[ParallelScriptRunner] = []
        for depth, deps in self.columns_rev.items():
            pscript_runner = ParallelScriptRunner([])
            for dep in deps:
                dep_spec = self.specs.get(dep)
                if dep_spec is None:
                    continue
                # TODO: actually run ordered scripts in order instead of in parralel
                pscript_runner.add_scripts(dep_spec.ordered_scripts)
            if not pscript_runner.is_empty():
                pscript_runners.append(pscript_runner)

        print(list(map(lambda pr: pr.unordered_scripts, pscript_runners)))
        print("\n---\n")
        print("Checking parralel runners' files")
        for pr in pscript_runners:
            if not pr.check():
                raise FileNotFoundError(
                    f"Error: parralel runner files check failed! {pr.unordered_scripts}"
                )
        print("digraph deps {")
        for name, spec in self.specs.items():
            for dep in spec.deps:
                print(f'  "{dep}" -> "{name}";')
        print("}")
        input("Press enter to run paraller script runners!")
        print("Running parralel runners...")
        for pr in pscript_runners:
            asyncio.run(pr.run())

        return None


def main() -> None:
    dep_manager = DepManager()

    with open("speclist", "r") as f:
        speclist = f.read().strip().split("\n")
        for spec_path in speclist:
            print(f"ADDING spec: {spec_path}")
            dep_manager.add_spec(Path(spec_path))
        print("---")

    with open("installist", "r") as f:
        installist = f.read().strip().split("\n")
        try:
            dep_manager.manage_some(installist)
        except FileNotFoundError | RecursionError as e:
            print(f"\n---\n{e}\n---\n")


if __name__ == "__main__":
    # main()
    script_runner = ParallelScriptRunner(["sed.sh", "apt.sh", "zip.sh"])
    assert script_runner.check() == True
    asyncio.run(script_runner.run())
