#!/usr/bin/env bash

# Import functions and env vars
source "${HOME}/.dotfiles/install/functions.sh"
source "${HOME}/.dotfiles/share/bash/bashrc"

DICT_LIST_FILE="${HOME}/.dotfiles/share/dictionaries/list.txt"

echo "=> Installing dictionaries from ${DICT_LIST_FILE}"

create_directory "${DICPATH}"

xargs -L1 "${HOME}/.dotfiles/share/dictionaries/download.sh" < "${DICT_LIST_FILE}"
