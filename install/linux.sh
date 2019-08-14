#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

create_symbolic_link "/usr/share/git-core/contrib/completion/git-prompt.sh" \
  "${HOME}/.git-prompt.sh"

create_symbolic_link "${HOME}/.dotfiles/bash/bashrc.linux" \
  "${HOME}/.bashrc.os"
