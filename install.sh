#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

echo -e "# Dotfiles Installation #\n"

create_directory "${HOME}/.emacs.d"
create_directory "${HOME}/.vim/.backup"
create_directory "${HOME}/.vim/.swap"
create_directory "${HOME}/.vim/.undo"
create_directory "${HOME}/.vim/after"

create_symbolic_link "${HOME}/.dotfiles/bash/bash_aliases" \
  "${HOME}/.bash_aliases"
create_symbolic_link "${HOME}/.dotfiles/bash/bashrc" \
  "${HOME}/.bashrc"
create_symbolic_link "${HOME}/.dotfiles/config/tigrc" \
  "${HOME}/.tigrc"
create_symbolic_link "${HOME}/.dotfiles/emacs/init.el" \
  "${HOME}/.emacs.d/init.el"
create_symbolic_link "${HOME}/.dotfiles/tmux/tmux.conf" \
  "${HOME}/.tmux.conf"
create_symbolic_link "${HOME}/.dotfiles/vim/after/ftplugin" \
  "${HOME}/.vim/after/ftplugin"
create_symbolic_link "${HOME}/.dotfiles/vim/vimrc" \
  "${HOME}/.vimrc"
create_symbolic_link "${HOME}/.dotfiles/vim/plugins.vim" \
  "${HOME}/.vim/plugins.vim"

source_file_if_linux "${HOME}/.dotfiles/install/linux.sh"
source_file_if_macos "${HOME}/.dotfiles/install/macos.sh"

echo -e "\n# Finish #"
