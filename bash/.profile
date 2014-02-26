# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export DOTFILES_PATH=~/.dotfiles
export BASH_SRC_PATH=$DOTFILES_PATH/bash

#define uname variables
MAC_UNAME="Darwin"
LINUX_UNAME="Linux"
WINDOWS_UNAME="MINGW32_NT-6.1"
CURRENT_UNAME=$(uname)

#include these for all bashes
source "$BASH_SRC_PATH"/.bashrc
source "$BASH_SRC_PATH"/.aliases
source "$BASH_SRC_PATH"/.functions

# include OS specific settings
if [ $CURRENT_UNAME != $WINDOWS_UNAME ]; then
    #do not use custom git prompt on windows, we're probably in git bash
    source "$BASH_SRC_PATH"/.prompt
fi
if [ $CURRENT_UNAME = $MAC_UNAME ]; then
    source "$BASH_SRC_PATH"/.profile-osx
    source "$BASH_SRC_PATH"/.aliases-osx
    source "$BASH_SRC_PATH"/.functions-osx
elif [ $CURRENT_UNAME = $LINUX_UNAME ]; then
    # include dummy file
    source "$BASH_SRC_PATH"/.linux
fi

# Bash shell completion with apt-get / brew package 'bash-completion'
if [ -f /usr/local/etc/bash_completion ]; then
  source /usr/local/etc/bash_completion
  elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Bash shell command completion
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# Bash shell MVN command completion
if [ -f ~/.maven_bash_completion.bash ]; then
    source ~/.maven_bash_completion.bash
fi

PATH="$DOTFILES_PATH/bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR=vi
export VISUAL=vi

export TERM=xterm-256color

# configure Maven
export MAVEN_OPTS='-ms256m -mx1024m -XX:PermSize=64m -XX:MaxPermSize=256m -Dfile.encoding=UTF-8 -Djava.awt.headless=true'
