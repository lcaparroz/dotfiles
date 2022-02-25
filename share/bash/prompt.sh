#!/usr/bin/env bash

# Bash Run Command script for custom prompt

__git_commit() {
	git rev-parse --short HEAD 2> /dev/null || return 1
}

__git_repodir() {
	git rev-parse --show-toplevel 2> /dev/null || return 1
}

__git_basedir() {
	local repodir
	repodir=$(__git_repodir) && basename "${repodir}" || return 1
}

__git_subdir() {
	local subdir inside_gitdir
	if ! subdir="$(git rev-parse --show-prefix 2> /dev/null)"
	then
		return 1
	elif inside_gitdir="$(__inside_gitdir)" && [ "${inside_gitdir}" = true ]
	then
		dirs && return 0
	elif [ -z "${subdir}" ]
	then
		echo "~" && return 0
	fi

	local dir_levels
	readarray -d '/' -t dir_levels <<< "${subdir%%*(/)}"
	local -r levels_count="${#dir_levels[*]}"

	local abbrev_path="${dir_levels[0]}"
	for (( n = 1; n < levels_count - 1; n++))
	do
		local level="${dir_levels[n]}"
		[ "${#level}" -gt 3 ] && level="${level:0:2}."
		abbrev_path+="/${level}"
	done
	[ "${levels_count}" -gt 1 ] && abbrev_path+="/${dir_levels[-1]}"

	echo "${abbrev_path}" && return 0
}

__inside_gitdir() {
	git rev-parse --is-inside-git-dir 2> /dev/null || return 1
}

__prompt_start() {
	local prompt
	prompt=""

	local basedir
	if basedir="$(__git_basedir)"
	then
		prompt+="\e[35m${basedir}\e[0m/"
		prompt+="\e[36m$(__git_subdir || dirs)\e[0m ("
		prompt+="\e[33m$(__git_commit || echo "--")\e[0m/"
	else
		prompt+="\e[36m$(dirs)\e[0m"
	fi

	echo -e "${prompt}\e[0m"
}

__prompt_end() {
	echo -e ")\n$(whoami)@$(hostname) $ "
}

__prompt_exit_code() {
	local exit_code="${1}"

	[ "${exit_code}" -eq 0 ] \
		&& printf "\e[0m[\e[32m%03d\e[0m]" "${exit_code}" \
		|| printf "\e[0m[\e[31m%03d\e[0m]" "${exit_code}"
}

PROMPT_START="\e[0m\$(__prompt_start)\e[0m"
PROMPT_END="$(__prompt_end)"
GIT_PROMPT_FORMAT="\e[0m%s"

if [ -r "${HOME}/.git-prompt.sh" ]
then
	# Bash prompt (PS1)
	PROMPT_COMMAND='__git_ps1 "\n$(__prompt_exit_code "$?") ${PROMPT_START}" "${PROMPT_END}" "${GIT_PROMPT_FORMAT}"'
else
	PS1="${PROMPT_START}${PROMPT_END}"
fi
