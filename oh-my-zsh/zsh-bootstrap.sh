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

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#install powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
