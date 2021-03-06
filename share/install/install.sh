#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/share/install/functions.sh"

echo -e "# Dotfiles Installation #\n"

create_directory "${HOME}/.config/kitty"
create_directory "${HOME}/.emacs.d"
create_directory "${HOME}/.vim/.backup"
create_directory "${HOME}/.vim/.swap"
create_directory "${HOME}/.vim/.undo"
create_directory "${HOME}/.vim/after"

create_dotfile_symlink "share/bash/bash_aliases" "${HOME}/.bash_aliases"
create_dotfile_symlink "share/bash/bashrc" "${HOME}/.bashrc"
create_dotfile_symlink "share/bash/profile" "${HOME}/.profile"
create_dotfile_symlink "share/config/tigrc" "${HOME}/.tigrc"
create_dotfile_symlink "share/emacs/init.el" "${HOME}/.emacs.d/init.el"
create_dotfile_symlink "share/kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
create_dotfile_symlink "share/kitty/themes" "${HOME}/.config/kitty/themes"
create_dotfile_symlink "share/tmux/tmux.conf" "${HOME}/.tmux.conf"
create_dotfile_symlink "share/tmux/themes" "${HOME}/.tmux_themes"
create_dotfile_symlink "share/vim/after/ftplugin" "${HOME}/.vim/after/ftplugin"
create_dotfile_symlink "share/vim/vimrc" "${HOME}/.vimrc"
create_dotfile_symlink "share/vim/plugins.vim" "${HOME}/.vim/plugins.vim"

source_file_if_linux "${HOME}/.dotfiles/linux/share/install.sh"
source_file_if_macos "${HOME}/.dotfiles/macos/install.sh"

echo -e "\n# Finish #"
