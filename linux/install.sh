#!/bin/env bash

sh <(curl -L https://nixos.org/nix/install) --daemon

ln -srf "nix" "$HOME/.config/nix"
