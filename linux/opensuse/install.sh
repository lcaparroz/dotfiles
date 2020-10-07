#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

# Install patterns
echo "=> Installing openSUSE patterns"
xargs sudo zypper install --type pattern --no-confirm --no-recommends \
  --download-in-heaps < "${HOME}/.dotfiles/linux/opensuse/patterns.txt"

# Install packages
echo "=> Installing openSUSE packages"
xargs sudo zypper install --type package --no-confirm --no-recommends \
  --download-in-heaps < "${HOME}/.dotfiles/linux/opensuse/packages.txt"

# Dotfiles
create_dotfile_symlink "linux/opensuse/config/fonts.conf" "${HOME}/.fonts.conf"
create_dotfile_symlink "linux/opensuse/config/gtkrc-2.0" \
  "${HOME}/.gtkrc-2.0.mine"
