#!/usr/bin/env bash

# Bash Run Command script for custom prompt

# Prompt style related constants
declare -r CLEAR_STYLE="\[\e[0m\]"

git_commit_id() {
  local -r commit_id=$(git rev-parse --short HEAD 2> /dev/null)

  if [[ -n "${commit_id}" ]]
  then
    echo "${commit_id}"
  fi
}

full_git_directory() {
  local -r git_dir=$(git rev-parse --show-toplevel 2> /dev/null)

  if [[ -n "${git_dir}" ]]
  then
    echo "${git_dir}"
  fi
}

git_base_directory() {
  local -r full_git_dir=$(full_git_directory)

  if [[ -n "${full_git_dir}" ]]
  then
    local git_base_dir

    git_base_dir="$(basename "${full_git_dir}")"

    echo "${git_base_dir}" #| awk '{print toupper($0)}'
  fi
}

git_subdirectory() {
  local -r full_git_dir="$(full_git_directory)"

  if [[ -n "${full_git_dir}" ]]
  then
    local -r current_dir="$(pwd)"
    local -r git_subdir="${current_dir/$full_git_dir/''}"

    if [[ -n "${git_subdir}" ]]
    then
      echo "${git_subdir:1}"
    fi
  fi
}

upper_prompt() {
  local -r dir_style="\e[36m"
  local -r clear_style="\e[0m"
  local -r git_base_dir="$(git_base_directory)"
  local prompt

  prompt="${dir_style}[$(dirs)]${clear_style}"

  if [[ -n "${git_base_dir}" ]]
  then
    local -r git_dir_style="\e[1;91m"
    local -r git_dir_slice="${git_dir_style}[${git_base_dir}]${clear_style}"

    local -r git_subdir_style="\e[36m"
    local git_subdir
    git_subdir="$(git_subdirectory)"

    if [[ -z "${git_subdir}" ]]
    then
      git_subdir="~"
    fi
    local -r git_subdir_slice=" ${git_subdir_style}${git_subdir}${clear_style}"

    local git_commit_style="\e[33m"
    local git_commit
    git_commit="$(git_commit_id)"

    if [[ -z "${git_commit}" ]]
    then
      git_commit="--"
    fi
    local git_commit_slice=" ${git_commit_style}${git_commit}${clear_style}"

    prompt="${git_dir_slice}${git_subdir_slice}${git_commit_slice}"
  fi

  echo -e "${prompt}\e[0m"
}

UPPER_LINE="\n\$(upper_prompt)${CLEAR_STYLE}"
LOWER_LINE="\n❯ "

if [ -f "${HOME}/.git-prompt.sh" ]
then
  source "${HOME}/.git-prompt.sh"

  # Export options for __git_ps1 command
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWSTASHSTATE=true
  export GIT_PS1_SHOWCOLORHINTS=true
  export GIT_PS1_SHOWUPSTREAM="auto"
  export GIT_PS1_DESCRIBE_STYLE="branch"

  # Bash prompt (PS1)
  PROMPT_COMMAND='__git_ps1 "${UPPER_LINE}" "${LOWER_LINE}"'
else
  PS1="${UPPER_LINE}${LOWER_LINE}"
fi
