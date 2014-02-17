#!/bin/bash

# be sure to bootstrap before running installation
/bin/bash brew-bootstrap.sh

### MISC
brew install python
brew install phantomjs
brew install ack
brew install htop
brew install dos2unix
brew install bash-completion
brew install wget
brew install nodejs

### TERMINAL / BASH
# installs the 4.X bash which is good for prompt extension with git. See http://buddylindsey.com/upgrade-bash-to-4-on-os-x/ for a how to.
brew install bash
brew install terminal-notifier

### GIT
brew install git

### JAVA
brew install jvmtop

### MAVEN
brew install maven
curl https://raw.github.com/juven/maven-bash-completion/master/bash_completion.bash -o ~/.maven_bash_completion.bash
