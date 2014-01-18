# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bash shell command completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Bash shell GIT prompt
if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=true
fi

# Bash shell MVN command completion
if [ -f ~/.maven_bash_completion.bash ]; then
    . ~/.maven_bash_completion.bash
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export JAVA_HOME=$(/usr/libexec/java_home)
export IDEA_JDK=$(/usr/libexec/java_home)

export EDITOR=vi
export VISUAL=vi

# configure Maven
export M2_HOME=/usr/local/opt/maven/libexec
export M2=/usr/local/opt/maven/libexec
export MAVEN_OPTS='-ms256m -mx1024m -XX:PermSize=64m -XX:MaxPermSize=256m -Dfile.encoding=UTF-8 -Djava.awt.headless=true'
# make sure maven does not steal focus when forking processes
export _JAVA_OPTIONS=-Djava.awt.headless=true

# configure p4
export P4CONFIG=.p4config
export PATH=/opt/p4/bin:$PATH
export PATH=/Applications/development/p4v/p4merge.app/Contents/MacOS:$PATH

# add current path as tab title in terminal
PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'


# insert /usr/local/bin before /usr/bin in order to overwrite system commands with homebrew commands
# also insert /usr/local/sbin
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
