# Nix Env
This document is mostly to remind me stuff

## Searching
[Nix packages website thingy](https://search.nixos.org/packages)

## Installing
```sh
nix-env -iA nixpkgs.<program>
```

## Uninstalling
```sh
nix-env --uninstall <program>
```

## Clearing Garbage thingy
```sh
nix-env --delete-generations old
```
