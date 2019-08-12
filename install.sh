#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

echo -e "# Dotfiles Installation #\n"

create_symbolic_link "${HOME}/.dotfiles/bash/bash_aliases" \
  "${HOME}/.bash_aliases"
create_symbolic_link "${HOME}/.dotfiles/bash/bashrc" \
  "${HOME}/.bashrc"
create_symbolic_link "${HOME}/.dotfiles/tmux/tmux.conf" \
  "${HOME}/.tmux.conf"
create_symbolic_link "${HOME}/.dotfiles/vim/vimrc" \
  "${HOME}/.vimrc"
create_symbolic_link "${HOME}/.dotfiles/vim/plugins.vim" \
  "${HOME}/.vim/plugins.vim"

create_directory "${HOME}/.vim/.undo"
create_directory "${HOME}/.vim/.backup"
create_directory "${HOME}/.vim/.swap"

source_file_if_linux "${HOME}/.dotfiles/install/linux.sh"
source_file_if_macos "${HOME}/.dotfiles/install/macos.sh"

echo -e "\n# Finish #"
