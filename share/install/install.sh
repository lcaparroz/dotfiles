#!/usr/bin/env bash

# Import functions
source "$HOME/.dotfiles/share/install/functions.sh"

echo -e "# Dotfiles Installation #\n"

create_directory "$HOME/.config/kitty"
create_directory "$HOME/.emacs.d"
create_directory "$HOME/.tmux"
create_directory "$HOME/.vim/.backup"
create_directory "$HOME/.vim/.swap"
create_directory "$HOME/.vim/.undo"
create_directory "$HOME/.vim/after"
create_directory "$HOME/workspace"

readonly CUSTOM_BIN="$HOME/opt/bin"
create_directory "$CUSTOM_BIN"

create_dotfile_symlink "share/bash/bash_profile" "$HOME/.bash_profile"
create_dotfile_symlink "share/bash/bashrc" "$HOME/.bashrc"
create_dotfile_symlink "share/bash/profile" "$HOME/.profile"
create_dotfile_symlink "share/bash/bash_aliases" "$HOME/.bash_aliases"
create_dotfile_symlink "share/config/tigrc" "$HOME/.tigrc"
create_dotfile_symlink "share/emacs/init.el" "$HOME/.emacs.d/init.el"
create_dotfile_symlink "share/git/gitconfig" "$HOME/.gitconfig"
create_dotfile_symlink "share/git/gitattributes" "$HOME/.gitattributes"
create_dotfile_symlink "share/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
create_dotfile_symlink "share/kitty/themes" "$HOME/.config/kitty/themes"
create_dotfile_symlink "share/tmux/tmux.conf" "$HOME/.tmux.conf"
create_dotfile_symlink "share/tmux/themes" "$HOME/.tmux/themes"
create_dotfile_symlink "share/tmux/sessions" "$HOME/.tmux/sessions"
create_dotfile_symlink "share/vim/after/ftplugin" "$HOME/.vim/after/ftplugin"
create_dotfile_symlink "share/vim/vimrc" "$HOME/.vimrc"
create_dotfile_symlink "share/vim/plugins.vim" "$HOME/.vim/plugins.vim"

# Link custom scripts
for f in ~/.dotfiles/share/bin/*
do
  create_symbolic_link "$f" "$CUSTOM_BIN"
done

source_file_if_linux "$HOME/.dotfiles/linux/share/install.sh"
source_file_if_macos "$HOME/.dotfiles/macos/install.sh"

echo -e "\n# Finish #"
