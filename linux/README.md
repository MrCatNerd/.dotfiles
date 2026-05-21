# Linux

This directory contains the dotfiles for my linux systems


Here are some details about my setup:

+ **OS**: [Ubuntu](https://ubuntu.com/) or [Fedora](https://fedoraproject.org/)
+ **WM**: [AwesomeWM](https://github.com/awesomeWM/awesome/)
+ **Shell**: [zsh](https://www.zsh.org/)
+ **Terminal**: [kitty](https://github.com/kovidgoyal/kitty/)
+ **Editor**: [Neovim](https://github.com/neovim/neovim/) btw
+ **Launcher**: [rofi](https://github.com/davatorium/rofi/)
+ **Main Theme**: [Rose Pine](https://rosepinetheme.com/)

---

## Requirements

ubuntu:
```sh
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
```

fedora:
```sh
sudo dnf install ansible -y
```

## Installation

clone and run the script

```sh
git clone "https://github.com/MrCatNerd/.dotfiles.git" "$HOME/.dotfiles/"
cd "$HOME/.dotfiles/linux/"
./scripts/install.sh
```
