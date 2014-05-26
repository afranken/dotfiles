#!/bin/bash

/bin/bash ../local/git-bootstrap.sh

#turn all color options on (with git 1.5.5+)
git config --global color.ui "auto"

#Configure line endings for operation system
git config --global core.autocrlf input

#enable aut-detection for number of threads to use (good for multi-CPU or multi-core computers) for packing repositories
git config --global pack.threads "0"

#Configure Git to detect renames on diff and merge.
git config --global diff.renamelimit 0
git config --global merge.renamelimit 25000

#Configure Git to use rebase by default
git config --global branch.autosetuprebase always

# permanent authentication for https git urls.
set git config --global credential.helper osxkeychain

#install bash completion
curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
