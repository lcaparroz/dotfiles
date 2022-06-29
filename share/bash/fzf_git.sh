#!/usr/bin/env bash

# fzf integration with git (functions)
_is_in_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}

_fzf_tmux() {
	fzf-tmux "$FZF_TMUX_OPTS" --reverse --bind ctrl-/:toggle-preview \
	--preview-window down:70%:border-top:wrap:hidden "$@"
}

# git status
_fzf_git_status() {
	_is_in_git_repo || return

	git -c color.status=always status --untracked-files=all --short \
	| _fzf_tmux -m --ansi --nth 2..,.. \
	--preview 'git diff -- {-1} | delta --hunk-header-style="line-number syntax" --features="decorations $SYSTEM_THEME"' \
	| cut -c4- \
	| sed 's/.* -> //'
}

# git branch
_fzf_git_branch() {
	_is_in_git_repo || return

	git branch -a --color=always \
	| grep -v '/HEAD\s' \
	| sort \
	| _fzf_tmux --ansi --multi --tac \
	--preview 'git log --oneline --date=short --color=always --pretty="%C(green)%cd %<(20,trunc)%C(magenta)%an%C(reset) %C(auto)%h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' \
	| sed 's/^..//' \
	| cut -d' ' -f1 \
	| sed 's#^remotes/##'
}

# git log
_fzf_git_log() {
	_is_in_git_repo || return

	git log --date=short --color=always \
	--format="%C(green)%cd %<(20,trunc)%C(magenta)%an%C(reset) %C(auto)%h%d %s" \
	| _fzf_tmux --ansi --no-sort --multi --bind 'ctrl-s:toggle-sort' \
	--header 'Press CTRL-S to toggle sort' \
	--preview 'git show --combined-all-paths -c --color=always $(grep -o "[a-f0-9]\{7,\}" <<< {}) | delta --features="decorations $SYSTEM_THEME"' \
	| grep -o "[a-f0-9]\{7,\}"
}

# git stash
_fzf_git_stash() {
	_is_in_git_repo || return

	git stash list \
	| _fzf_tmux --preview 'git stash show -p $(grep -oE "^stash@{[0-9]+}" <<< {}) | delta --features="decorations $SYSTEM_THEME"' \
	| cut -d: -f1
}
