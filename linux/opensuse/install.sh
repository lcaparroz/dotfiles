#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

# Install dependencies
echo "=> Installing openSUSE dependencies (packages)"
xargs sudo zypper install --no-confirm --no-recommends --download-in-heaps \
  < "${HOME}/.dotfiles/linux/opensuse/dependencies.txt"

# Dotfiles
create_dotfile_symlink "linux/opensuse/config/fonts.conf" "${HOME}/.fonts.conf"
create_dotfile_symlink "linux/opensuse/config/gtkrc-2.0"  "${HOME}/.gtkrc-2.0"
