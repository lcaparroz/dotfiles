#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

readonly KARABINER_DIR="${HOME}/.config/karabiner"
readonly KARABINER_MODS_DIR="${KARABINER_DIR}/assets/complex_modifications"

# Karabiner configuration
create_directory KARABINER_MODS_DIR
create_symbolic_link \
  "${HOME}/.dotfiles/macos/karabiner/custom_modifications.json" \
  "${KARABINER_MODS_DIR}/custom.json"

create_symbolic_link "/usr/local/etc/bash_completion.d/git-prompt.sh" \
  "${HOME}/.git-prompt.sh"

create_symbolic_link "${HOME}/.dotfiles/bash/bashrc.macos" \
  "${HOME}/.bashrc.os"
