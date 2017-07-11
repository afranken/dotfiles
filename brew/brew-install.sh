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

# be sure to bootstrap before running installation
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
${DIR}/brew-bootstrap.sh

FORMULAE=(
  ### TERMINAL / BASH
  bash
  bash-completion
  terminal-notifier
  
  ### MISC
  python

  ### GIT
  git
  #see https://github.com/magicmonty/bash-git-prompt
  bash-git-prompt
)

### INSTALL
brew install ${FORMULAE[@]}

### BASH COMPLETION
if [ ! -f ~/.maven_bash_completion.bash ]; then
  curl https://raw.githubusercontent.com/juven/maven-bash-completion/master/bash_completion.bash -o ~/.maven_bash_completion.bash
fi

if [ ! -f ~/.git-completion.bash ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

### Set newly installed bash as default (otherwise, shell scripts will use the 3.0 bash if the shebang is "#!/bin/bash")
# Add the new shell to the list of allowed shells
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell
chsh -s /usr/local/bin/bash
