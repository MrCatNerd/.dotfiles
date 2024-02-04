# Linux
This directory contains the dotfiles for my linux system

---

**Attention: Uninstalling Nix is a substantial operation. Refer to the official documentation [here](https://nixos.org/manual/nix/stable/installation/uninstall) for guidance. Additionally, use the removal script `linux/others/remove_multiusernix.sh` at your own risk.**

## Requirements

Ensure you have the following installed on your system,
other dependencies are being installed by the script

### Git

```sh
sudo apt-get install -y git
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```sh
git clone https://github.com/MrCatNerd/.dotfiles.git $HOME/.dotfiles/
cd $HOME/.dotfiles/linux/

# to use the latest stuff (optional):
#git switch dev
```

then run the script to use my config

```sh
./debian.sh
# TODO: arch
```

if there are any errors, just remember that i am a bad programmer

---

## TODO

- Arch script
- Fix my nix package manager mess
- Test this mess and fix small bugs
- Create a stable branch ^

"Dotfiles, a whirlwind of chaos, where hours vanish into a vortex of broken dreams" - Alfred Einstein 1995

