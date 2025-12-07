#!/bin/sh

# u can't use sudo meson install -C builddir
# u must use sudo ninja install -C builddir
# this is why i hate all python package managers
uv tool install meson
