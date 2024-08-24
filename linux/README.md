# Linux

This directory contains the dotfiles for my linux system


Here are some details about my setup:

+ **WM**: [AwesomeWM](https://github.com/awesomeWM/awesome/) 🗔 config included!
+ **OS**: [Pop!_OS](https://pop.system76.com/)
+ **Shell**: [zsh](https://wiki.archlinux.org/index.php/Zsh/)
+ **Terminal**: [kitty](https://github.com/kovidgoyal/kitty/) 🐱 config included!
+ **Editor**: [Neovim](https://github.com/neovim/neovim/) 🖹 config included!
<!-- + **File Manager**: [Thunar](https://git.xfce.org/xfce/thunar/) -->
+ **Launcher**: [rofi](https://github.com/davatorium/rofi/) 🚀 config included!
+ **Browser**: [Firefox](https://www.mozilla.org/en-US/firefox/) <!-- TODO: add config (maybe) -->
+ **Main Theme**: [Rose Pine](https://rosepinetheme.com/)

---

**Attention: Uninstalling Nix is a substantial operation. Refer to the official documentation [here](https://nixos.org/manual/nix/stable/installation/uninstall) for guidance. Additionally, use the removal script `linux/others/remove_multiusernix.sh` at your own risk.** <!-- totally not ChatGPT -->

## Requirements

Ensure you have the following installed on your system,
other dependencies are being installed by the script (at least i think so idk maybe they aren't what are you gonna do about it)

### Nix Package Manager
Via [NixOS](https://nixos.org/download)


### Git

```sh
sudo apt-get install -y git
```

## Installation

First, check out the dotfiles repo in your home directory using git

```sh
git clone "https://github.com/MrCatNerd/.dotfiles.git" "$HOME/.dotfiles/"
#git switch dev # To use the latest stuff
cd "$HOME/.dotfiles/linux/"
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

