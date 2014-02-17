# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

DOTFILES_PATH=~/.dotfiles
BASH_SRC_PATH=$DOTFILES_PATH/bash

#include all files from this repository
source "$BASH_SRC_PATH"/.bashrc
source "$BASH_SRC_PATH"/.aliases
source "$BASH_SRC_PATH"/.prompt
source "$BASH_SRC_PATH"/.functions

# include OS specific settings
if [ $(uname) = "Darwin" ]; then
    source "$BASH_SRC_PATH"/.profile-osx
    source "$BASH_SRC_PATH"/.aliases-osx
    source "$BASH_SRC_PATH"/.functions-osx
elif [ $(uname) = "Linux" ]; then
    # include dummy file
    source "$BASH_SRC_PATH"/.linux
fi

# Bash shell completion with brew package 'bash-completion'
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

# Bash shell command completion
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# Bash shell GIT prompt
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=true
fi

# Bash shell MVN command completion
if [ -f ~/.maven_bash_completion.bash ]; then
    source ~/.maven_bash_completion.bash
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR=vi
export VISUAL=vi

export TERM=xterm-256color

# configure Maven
export MAVEN_OPTS='-ms256m -mx1024m -XX:PermSize=64m -XX:MaxPermSize=256m -Dfile.encoding=UTF-8 -Djava.awt.headless=true'
