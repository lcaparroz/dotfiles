#!/usr/bin/env bash

# Bash Run Command script for custom prompt

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
  local -r git_subdir="$(git rev-parse --show-prefix 2> /dev/null)"

  if [[ -n "${git_subdir}" ]]
  then
    local -r current_dir_basename="$(basename "${git_subdir}")"
    local git_subdir_levels
    readarray -d '/' -t git_subdir_levels <<< "${git_subdir%%*(/)}"
    local -r level_count="${#git_subdir_levels[*]}"

    local formatted_dir_levels
    for (( n = 1; n < level_count - 1; n++))
    do
      local level_string="${git_subdir_levels[n]}"
      if [ "${#level_string}" -gt 3 ]
      then
        level_string="${level_string:0:2}."
      fi
      formatted_dir_levels="${formatted_dir_levels}/${level_string}"
    done

    if [ -n "${formatted_dir_levels}" ]
    then
      echo "${git_subdir_levels[0]}${formatted_dir_levels}/${current_dir_basename}"
    elif [ "${level_count}" -gt 1 ]
    then
      echo "${git_subdir_levels[0]}/${current_dir_basename}"
    else
      echo "${current_dir_basename}"
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

UPPER_LINE="\n\e[1m\u@\h\e[0m \$(upper_prompt)\e[0m"
LOWER_LINE="\n❯ "

if [ -r "${HOME}/.git-prompt.sh" ]
then
  # Bash prompt (PS1)
  PROMPT_COMMAND='__git_ps1 "${UPPER_LINE}" "${LOWER_LINE}"'
else
  PS1="${UPPER_LINE}${LOWER_LINE}"
fi
