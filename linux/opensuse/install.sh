#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

# Install dependencies
echo "=> Installing openSUSE dependencies (packages)"
xargs sudo zypper install --no-confirm --no-recommends --download-in-heaps \
  < "${HOME}/.dotfiles/linux/opensuse/dependencies.txt"
