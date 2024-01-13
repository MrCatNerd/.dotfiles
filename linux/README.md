# Linux

---

### WARNING: good luck [uninstalling nix](https://nixos.org/manual/nix/stable/installation/uninstall)

```sh
(export DOTFILES_DIR="your dotfiles dir"&& chmod +x scripts/start.sh)
./scripts/start.sh
```

structure:
    every config directory should have a setup.sh script that will be executed by scripts/setup_dotfiles.sh
