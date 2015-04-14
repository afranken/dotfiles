#!/usr/bin/env bash

# be sure to bootstrap before running installation
/bin/bash brew-bootstrap.sh

FORMULAE=(
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
  
  ### TERMINAL / BASH
  bash
  terminal-notifier
  
  ### GIT
  git
  #see https://github.com/magicmonty/bash-git-prompt
  bash-git-prompt
  
  ### JAVA
  jvmtop

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
