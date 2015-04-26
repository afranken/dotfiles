#!/usr/bin/env bash

# be sure to bootstrap before running installation
/bin/bash brew-bootstrap.sh

FORMULAE=(
  ### TERMINAL / BASH
  bash
  terminal-notifier
  
  ### MISC
  python
  phantomjs
  ack
  htop
  dos2unix
  bash-completion
  wget
  nodejs
  groovy
  
  ### GIT
  git
  #see https://github.com/magicmonty/bash-git-prompt
  bash-git-prompt
  
  ### MAVEN
  maven

  ### SCALA
  scala
  sbt

  ### JavaScript
  npm

  #app development
  ios-sim
  android-sdk
)

### INSTALL
brew install ${FORMULAE[@]}

### BASH COMPLETION
if [ ! -f ~/.maven_bash_completion.bash ];
then
  curl https://raw.github.com/juven/maven-bash-completion/master/bash_completion.bash -o ~/.maven_bash_completion.bash
fi

### Set newly installed bash as default (otherwise, shell scripts will use the 3.0 bash if the shebang is "#!/bin/bash")
# Add the new shell to the list of allowed shells
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell
chsh -s /usr/local/bin/bash
