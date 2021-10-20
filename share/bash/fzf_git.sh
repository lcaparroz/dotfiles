#!/usr/bin/env bash

# fzf integration with git (functions)
_is_in_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}
_fzf_tmux() {
	fzf-tmux "$FZF_TMUX_OPTS" --reverse --bind ctrl-/:toggle-preview \
	--preview-window right:50%:border-left:hidden "$@"
}

# git status
_fzf_git_status() {
	_is_in_git_repo || return

	git -c color.status=always status --untracked-files=all --short \
		| _fzf_tmux -m --ansi --nth 2..,.. \
		--preview '(git diff -- {-1} | delta --hunk-header-style="line-number syntax")' \
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
		--preview 'git log --oneline --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' \
		| sed 's/^..//' \
		| cut -d' ' -f1 \
		| sed 's#^remotes/##'
}

# git log
_fzf_git_log() {
	_is_in_git_repo || return

	git log --date=short \
	--format="%C(green)%cd %<(14,trunc)%C(magenta)%an%C(reset) %C(auto)%h%d %s" \
	--color=always \
		| _fzf_tmux --ansi --no-sort --multi --bind 'ctrl-s:toggle-sort' \
		--header 'Press CTRL-S to toggle sort' \
		--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs -I%% bash -c "git show --combined-all-paths -c --color=always %% | delta"' \
		| grep -o "[a-f0-9]\{7,\}"
}

# git stash
_fzf_git_stash() {
	_is_in_git_repo || return

	git stash list \
		| _fzf_tmux --preview 'git stash show -p $(grep -o "^stash@{[0-9]+}" <<< {}) | delta' \
		| cut -d: -f1
}
