#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/install/functions.sh"

echo -e "# Dotfiles Installation #\n"

create_directory "${HOME}/.config/kitty"
create_directory "${HOME}/.emacs.d"
create_directory "${HOME}/.vim/.backup"
create_directory "${HOME}/.vim/.swap"
create_directory "${HOME}/.vim/.undo"
create_directory "${HOME}/.vim/after"

create_dotfile_symlink "bash/bash_aliases" "${HOME}/.bash_aliases"
create_dotfile_symlink "bash/bashrc" "${HOME}/.bashrc"
create_dotfile_symlink "config/tigrc" "${HOME}/.tigrc"
create_dotfile_symlink "emacs/init.el" "${HOME}/.emacs.d/init.el"
create_dotfile_symlink "kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
create_dotfile_symlink "kitty/themes" "${HOME}/.config/kitty/themes"
create_dotfile_symlink "tmux/tmux.conf" "${HOME}/.tmux.conf"
create_dotfile_symlink "tmux/themes" "${HOME}/.tmux_themes"
create_dotfile_symlink "vim/after/ftplugin" "${HOME}/.vim/after/ftplugin"
create_dotfile_symlink "vim/vimrc" "${HOME}/.vimrc"
create_dotfile_symlink "vim/plugins.vim" "${HOME}/.vim/plugins.vim"

source_file_if_linux "${HOME}/.dotfiles/install/linux.sh"
source_file_if_macos "${HOME}/.dotfiles/install/macos.sh"

echo -e "\n# Finish #"
