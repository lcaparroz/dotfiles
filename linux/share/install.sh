#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

# Local functions

linux_distro_is() {
  local -r distro_string="$1"

  hostnamectl | grep -qi "${distro_string}"
  return
}

create_dotfile_symlink "linux/share/bash/bashrc" "${HOME}/.bashrc.os"
create_dotfile_symlink "linux/share/bash/profile" "${HOME}/.profile.os"

# Link custom scripts
readonly CUSTOM_BIN="${HOME}/opt/bin"
create_directory "${CUSTOM_BIN}"

for f in ~/.dotfiles/linux/share/bin/*
do
  create_symbolic_link "$f" "${CUSTOM_BIN}"
done

# Install dependencies
if linux_distro_is "openSUSE"
then
  ~/.dotfiles/linux/opensuse/install.sh
fi

# i3wm configuration
if [ -n "$(command -v i3)" ]
then
  create_directory "${HOME}/.config/i3"
  create_dotfile_symlink "linux/share/i3/config" "${HOME}/.config/i3/config"

  create_directory "${HOME}/.config/i3status"

  if linux_distro_is "openSUSE"
  then
    create_dotfile_symlink "linux/opensuse/i3/i3status/config" \
      "${HOME}/.config/i3status/config"
  else
    create_dotfile_symlink "linux/share/i3/i3status/config" \
      "${HOME}/.config/i3status/config"
  fi
  create_dotfile_symlink "linux/share/feh/fehbg" "${HOME}/.fehbg"
  create_dotfile_symlink "linux/share/rofi" "${HOME}/.config"

  if [ -n "$(command -v dunst)" ]
  then
    create_directory "${HOME}/.config/dunst"
    create_dotfile_symlink "linux/share/dunst/dunstrc" "${HOME}/.config/dunst/dunstrc"
  fi
fi

# git prompt file
if [ -f "/etc/bash_completion.d/git-prompt.sh" ]
then
  create_symbolic_link "/etc/bash_completion.d/git-prompt.sh" \
    "${HOME}/.git-prompt.sh"
elif [ -f "/usr/share/git-core/contrib/completion/git-prompt.sh" ]
then
  create_symbolic_link "/usr/share/git-core/contrib/completion/git-prompt.sh" \
    "${HOME}/.git-prompt.sh"
elif [ -f "/usr/share/bash-completion/completions/git-prompt.sh" ]
then
  create_symbolic_link "/usr/share/bash-completion/completions/git-prompt.sh" \
    "${HOME}/.git-prompt.sh"
fi

# fonts installation
~/.dotfiles/linux/share/fonts/install.sh
