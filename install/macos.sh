#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

create_dotfile_symlink "bash/bashrc.macos" "${HOME}/.bashrc.os"
create_dotfile_symlink "bash/profile.macos" "${HOME}/.profile.os"

# macOS startup files configuration
readonly USER_LAUNCH_AGENTS_DIR="${HOME}/Library/LaunchAgents"
readonly USER_STARTUP_AGENT="${USER_LAUNCH_AGENTS_DIR}/com.startup.plist"

create_directory "${USER_LAUNCH_AGENTS_DIR}"
create_dotfile_symlink "macos/plist/com.startup.plist" "${USER_STARTUP_AGENT}"
create_dotfile_symlink "scripts/system_theme.sh" "/usr/local/bin/system_theme"
launchctl load -wF "${USER_STARTUP_AGENT}" 2&> /dev/null

# Karabiner configuration
readonly KARABINER_DIR="${HOME}/.config/karabiner"
readonly KARABINER_MODS_DIR="${KARABINER_DIR}/assets/complex_modifications"

create_directory "${KARABINER_MODS_DIR}"
create_dotfile_symlink \
  "macos/karabiner/custom_modifications.json" \
  "${KARABINER_MODS_DIR}/custom.json"

# Kitty configuration
create_dotfile_symlink \
  "kitty/kitty.macos.conf" \
  "${HOME}/.config/kitty/kitty.os.conf" \

# git prompt file
create_symbolic_link "/usr/local/etc/bash_completion.d/git-prompt.sh" \
  "${HOME}/.git-prompt.sh"
