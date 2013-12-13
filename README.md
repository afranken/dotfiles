mac-config
==========

This assumes a fresh OSX installation

## First steps:
* install xcode via appstore
* open terminal and install [homebrew](http://brew.sh/) (installs packages from source easily)
* run `launchctl setenv PATH /usr/local/bin:$PATH` on a bash [why?](https://github.com/mxcl/homebrew/wiki/FAQ#my-mac-apps-dont-find-usrlocalbin-utilities)

## General Brew Formulas
* `brew install python` (installs python which is necessary to use pip and to install python tools like stormssh)
* `brew install phantomjs`
* `brew install ack` ([beyondgrep.com](http://www.beyondgrep.com) "a tool like grep, optimized for programmers")
* `brew install htop`
* `brew install dos2unix`

## Bash
* `brew install bash` - installs the 4.X bash which is good for prompt extension with git. See [upgrade-bash-to-4-on-os-x](http://buddylindsey.com/upgrade-bash-to-4-on-os-x/) for a how to.
* `brew install terminal-notifier` - a nice way to use the notification center from bash scripts

## Git
* `brew install git` install git
* add colors and prompt enhancement
    * `cd ~/`
    * `curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o .git-prompt.sh`
    * `curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o .git-completion.bash`
* `set git config --global credential.helper osxkeychain` (permanently authenticate for https git urls.)

## Java
* `export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)`
* `export _JAVA_OPTIONS='-Djava.net.preferIPv4Stack=true -Djava.awt.headless=true'`
* `brew install jvmtop`

## Maven
* `brew install maven` (to get latest 3.1.x)
* [nmvn](https://github.com/geoffreywiseman/maven-notification-center) - a shell script to trigger terminal-notifier when a maven build has finished, add to "~/bin"
* bash_completion.bash
    * `cd ~/`
    * `curl https://raw.github.com/juven/maven-bash-completion/master/bash_completion.bash -o .maven_bash_completion.bash`

## Bash config
* `cd ~/`
* `git clone https://github.com/afranken/mac-config.git`
    * `ln -s mac-config/.bash_aliases .bash_aliases`
    * `ln -s mac-config/.bashrc .bashrc`
    * `ln -s mac-config/.profile .profile`
