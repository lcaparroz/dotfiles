#!/usr/bin/env bash

# Import functions and env vars
source "${HOME}/.dotfiles/bash/bashrc"
source "${HOME}/.dotfiles/install/functions.sh"

DICT_LIST_FILE="${HOME}/.dotfiles/dictionaries/list.txt"

echo "=> Installing dictionaries from ${DICT_LIST_FILE}"

create_directory "${DICPATH}"

xargs -L1 "${HOME}/.dotfiles/dictionaries/download.sh" < "${DICT_LIST_FILE}"
