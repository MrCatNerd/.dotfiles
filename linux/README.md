# Linux

This directory contains the dotfiles for my linux system


Here are some details about my setup:

+ **OS**: [Ubuntu](https://ubuntu.com/)
+ **WM**: [AwesomeWM](https://github.com/awesomeWM/awesome/) ⌨️ config included!
+ **Shell**: [zsh](https://wiki.archlinux.org/index.php/Zsh/) 🗔 config included
+ **Terminal**: [kitty](https://github.com/kovidgoyal/kitty/) 🐱 config included!
+ **Editor**: [Neovim](https://github.com/neovim/neovim/) btw 🖹 config included!
+ **Launcher**: [rofi](https://github.com/davatorium/rofi/) 🚀 config included!
+ **Main Theme**: [Rose Pine](https://rosepinetheme.com/) 🌷

---

## Requirements

Ensure you have the following installed on your system,
other dependencies are being installed by the script (at least I think so maybe they aren't what are you gonna do about it)


### Git

```sh
sudo apt-get install -y git
```

## Installation

First, check out the dotfiles repo in your home directory using git

```sh
git clone "https://github.com/MrCatNerd/.dotfiles.git" "$HOME/.dotfiles/"
cd "$HOME/.dotfiles/linux/"
./debian.sh
```

if there are any errors, just remember that i am a bad programmer

---

## TODO

- Fix nerd font installation
