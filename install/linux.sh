#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

create_dotfile_symlink "bash/bashrc.linux" "${HOME}/.bashrc.os"
create_dotfile_symlink "config/profile" "${HOME}/.profile"

# i3wm configuration
if [ -n "$(command -v i3)" ]
then
  create_directory "${HOME}/.config/i3"
  create_dotfile_symlink "i3/config" "${HOME}/.config/i3/config"
fi

# git prompt file
if [ -f "/usr/share/git-core/contrib/completion/git-prompt.sh" ]
then
  create_symbolic_link "/usr/share/git-core/contrib/completion/git-prompt.sh" \
    "${HOME}/.git-prompt.sh"
fi
