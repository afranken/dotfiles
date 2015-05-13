#!/bin/bash
###
# use "bash strict mode", @see http://redsymbol.net/articles/unofficial-bash-strict-mode/
# https://sipb.mit.edu/doc/safe-shell/
set -euf
if [ "${BASH_VERSINFO[0]}" -ge 3 ]; then
  set -o pipefail
fi
IFS=$'\n\t'
###
# use command debugging
#set -x

sudo apt-get install openssh-server
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install build-essential
sudo apt-get install curl

sudo apt-get install maven
curl https://raw.github.com/juven/maven-bash-completion/master/bash_completion.bash -o ~/.maven_bash_completion.bash
sudo apt-get install nodejs
sudo apt-get install phantomjs

