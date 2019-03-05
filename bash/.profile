# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export DOTFILES_PATH=~/.dotfiles
export SHELLS_SRC_PATH=${DOTFILES_PATH}/all_shells
export BASH_SRC_PATH=${DOTFILES_PATH}/bash

source ${SHELLS_SRC_PATH}/.profile

#define uname variables
MAC_UNAME="Darwin"
CURRENT_UNAME=$(uname)

#include these for all bashes
source "${BASH_SRC_PATH}"/.bashrc

# include OS specific settings
if [ ${CURRENT_UNAME} == ${MAC_UNAME} ]; then
  source "${BASH_SRC_PATH}"/.bashrc-osx
fi

#just dummy values to make the AWS-SDK happy during local tests.
export AWS_ACCESS_KEY_ID=NONE
export AWS_SECRET_KEY=NONE
