#!/bin/bash

#set your name here
git config --global user.name "${GIT_USERNAME}"
#set your email here
git config --global user.email $GIT_EMAIL

#turn all color options on (with git 1.5.5+)
git config --global color.ui "auto"

#Configure line endings for operation system
git config --global core.autocrlf input

#enable aut-detection for number of threads to use (good for multi-CPU or multi-core computers) for packing repositories
git config --global pack.threads "0"

#Configure Git to detect renames on diff and merge.
git config --global diff.renamelimit 0
git config --global merge.renamelimit 0

#make sure that Git reuses information about recent conflict resolutions.
git config --global rerere.enabled true

#Configure Git to use rebase by default
git config --global branch.autosetuprebase always

# permanent authentication for https git urls.
set git config --global credential.helper osxkeychain

#install bash completion
curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

### add git aliases
git config --global alias.a 'add'
git config --global alias.ap 'add --patch'
git config --global alias.cm '!git add -A && git commit -m'
git config --global alias.c 'commit --message'
git config --global alias.cam 'commit -a --message'

git config --global alias.co 'checkout'
git config --global alias.cob 'checkout -b'

## always purge branches on fetch.
git config --global alias.f 'fetch --prune'
## always rebase on pull
git config --global alias.up '!git pull --rebase --prune $@ && git submodule update --init --recursive'
## update and merge upstream into local branch
git config --global alias.mergeupstream '!git fetch origin -v; git fetch upstream -v; git merge upstream/master'

## show short status
git config --global alias.s 'status --short --branch'

## show nice formatted list
git config --global alias.ls 'log --pretty=format:"%C(bold red)%h%Creset -%C(bold yellow)%d%Creset %s %C(bold green)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
## show nice formatted list with line stats (added / deleted) per file
git config --global alias.ll '!git ls --numstat'
## show nice formatted graph
git config --global alias.lg '!git ls --graph'
## show all commits that deleted files
git config --global alias.ld 'log --diff-filter=D --summary'
## show full history for file, detect file movement
git config --global alias.lf '!git ls --follow'
## show log without colors (e.g. for "grep"ing the output)
git config --global alias.lnc 'log --pretty=format:"%h -%d %s (%cr) <%an>"'
## show tags with date, sorted by commit. No commit date is available for lightweight tags.
git config --global alias.lt 'for-each-ref --sort=taggerdate --format "%(refname) %(taggerdate:short)" refs/tags | less'
## show log for a file
git config --global alias.fl 'log -u'
## show only files for a commit
git config --global alias.showfiles 'diff-tree --no-commit-id --name-status -r'
## show previously deleted file in latest known revision
git config --global alias.showrm '!f() { git show $(git rev-list --max-count=1 --all -- $1)^:$1; }; f'

## list aliases
git config --global alias.la '!git config -l | grep alias | cut -c 7-'

## soft reset changes (i.e. reset commit, leave edited files in working tree)
git config --global alias.rs 'reset --soft "HEAD^"'
## hard reset changes (i.e. reset commit, trash edited files in working tree)
git config --global alias.rh 'reset --hard'
