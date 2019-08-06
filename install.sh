#!/bin/bash

# Dotfiles installation
readonly SUCCESS=0
readonly FAIL=1
readonly BACKUP_SUFFIX='.dotfiles.bkp'
readonly DOTFILES_LOG="${HOME}/.dotfiles.log"

function create_symbolic_link() {
  local target_file=$1
  local symlink_destination=$2

  local msg_create_backup
  local msg_create_symlink
  msg_create_backup='* Create backup file for'
  msg_create_symlink='* Create symbolic link for'

  echo -e "\nCreating symbolic link for ${target_file}:"
  if [[ -L "${symlink_destination}" ]] ; then
    local symlink_target
    symlink_target=$(readlink "${symlink_destination}")
    echo ". Found a symbolic link. Target: ${symlink_target}"
    if [[ "${symlink_target}" = "${target_file}" ]] ; then
      echo '.. Target is ok (no further action required).'
      return "${SUCCESS}"
    else
      echo '.. Unexpected target. Required actions:'
      echo "... ${msg_create_backup} ${symlink_destination};"
      echo "... ${msg_create_symlink} ${target_file}."
    fi
  else
    if [[ -f "${destination_symlink}" ]] ; then
      echo '. Found a file (not a symbolic link).'
      echo '.. Required actions:'
      echo "... ${msg_create_backup} ${symlink_destination};"
      echo "... ${msg_create_symlink} ${target_file}."
    else
      echo '. No file or symbolic link found.'
      echo '.. Required actions:'
      echo "... ${msg_create_symlink} ${target_file}."
    fi
  fi

  echo -e "\n. Executing actions:"
  ln --symbolic --backup=existing --suffix="${BACKUP_SUFFIX}" \
    "${target_file}" "${symlink_destination}" 2>> "${DOTFILES_LOG}"
  if [[ "$?" -ne 0 ]]; then
    echo ".. Error on creating symbolic link."
    echo '. Error on creating symbolic link:' >> "${DOTFILES_LOG}"
    echo -e ".. ${symlink_destination} -> ${target_file}\n" \
      >> "${DOTFILES_LOG}"
    return "${FAIL}"
  else
    local backup_file
    backup_file="${symlink_destination}${BACKUP_SUFFIX}"
    if [[ -e "${backup_file}" ]] ; then
      echo ".. Backup in: ${backup_file}"
    fi
    if [[ -L "${symlink_destination}" ]] ; then
      echo ".. Symbolic link in: ${symlink_destination}"
      echo "... Target in: ${target_file}"
    fi
  fi
  return "${SUCCESS}"
}

function create_directory() {
  local directory=$1
  echo -e "\nCreating directory ${directory}:"
  mkdir -p "${directory}" 2>> "${DOTFILES_LOG}"
  if [[ "$?" -ne 0 ]] ; then
    echo '. Error on creating directory.'
    echo -e ". Error on creating directory.\n" >> "${DOTFILES_LOG}"
  else
    echo '. Directory successfully created.'
  fi
}

echo -e "\n[DOTFILES INSTALLATION] Started at $(date)\n" >> "${DOTFILES_LOG}"

echo '# Dotfiles Installation #'

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

echo '# Finish #'

echo -e "\n[DOTFILES INSTALLATION] Ended at $(date)\n" >> "${DOTFILES_LOG}"
