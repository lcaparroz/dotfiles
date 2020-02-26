#!/usr/bin/env bash

# Import functions
source "${HOME}/.dotfiles/bash/functions.sh"

create_symbolic_link() {
  local target_file=$1
  local symlink_destination=$2

  if [ -L "${symlink_destination}" ]
  then
    local symlink_target
    symlink_target=$(readlink "${symlink_destination}")

    if [ "${symlink_target}" = "${target_file}" ]
    then
    echo "=> Symbolic link already exists: ${target_file} -> ${symlink_destination}"
      return 0
    fi
  fi

  if ln -sf "${target_file}" "${symlink_destination}"
  then
    echo "=> Symbolic link created: ${target_file} -> ${symlink_destination}"
  fi
}

create_directory() {
  local directory=$1

  if [ -d "${directory}" ]
  then
    echo "=> Directory already exists: ${directory}"
    return 0
  fi

  if mkdir -p "${directory}"
  then
    echo "=> Directory created: ${directory}"
  fi
}

source_file_if_linux() {
  local -r file_name="$1"

  if [ "$(uname -s)" = "Linux" ]
  then
    source_file "${file_name}"
  fi
}

source_file_if_macos() {
  local -r file_name="$1"

  if [ "$(uname -s)" = "Darwin" ]
  then
    source_file "${file_name}"
  fi
}
