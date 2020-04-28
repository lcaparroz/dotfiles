#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

# Local functions

linux_distro_is() {
  local -r distro_string="$1"

  [ -n "$(hostnamectl | grep -m 1 -i "${distro_string}")" ]
}

declare CUSTOM_BIN="${HOME}/opt/bin"
create_directory "${CUSTOM_BIN}"

for f in ~/.dotfiles/linux/share/bin/*
do
  create_symbolic_link "$f" "${CUSTOM_BIN}"
done

create_dotfile_symlink "linux/share/bash/bashrc" "${HOME}/.bashrc.os"
create_dotfile_symlink "linux/share/bash/profile" "${HOME}/.profile.os"

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

  create_dotfile_symlink "linux/share/rofi" "${HOME}/.config"
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
fi
