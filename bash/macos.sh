#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/bash/functions.sh"

export CLICOLOR=1

# Source fzf key-bindings/completion
source_file "/usr/local/opt/fzf/shell/completion.bash"
source_file "/usr/local/opt/fzf/shell/key-bindings.bash"

# Source bash completion files symlinked by brew
if [ -d "/usr/local/etc/bash_completion.d/" ]
then
  for f in /usr/local/etc/bash_completion.d/*
  do
    source "$f"
  done
fi
