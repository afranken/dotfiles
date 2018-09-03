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

base_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

## check whether XCode command line tools are already installed, otherwise install.
if [ $(xcode-select -p &> /dev/null) -g 0 ]; then
  xcode-select --install
fi

# Install brew and taps
if ! hash "brew"; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/cask-fonts
    #use `brew cu` for easy cask upgrades https://github.com/buo/homebrew-cask-upgrade
    brew tap buo/cask-upgrade
fi

##link Cellar into User Home for easy access from various applications (e.g. for setting JDKs in IntelliJ Idea)
if [ ! -L ~/Cellar ];
then
  ln -s /usr/local/Cellar ~/Cellar
fi

##link Caskroom into User Home for easy access from various applications (e.g. for setting JDKs in IntelliJ Idea)
if [ ! -L ~/Caskroom ];
then
  ln -s /opt/homebrew-cask/Caskroom/ ~/Caskroom
fi

# Syntax:
#
#   install file cmd regex
#
# Runs the install `cmd` for each line of the file, filtered with the regex
#
function install {
    install_file=$1
    install_cmd=$2
    install_regex=$3
    while read line; do
        id=`echo ${line} | sed -E "s/${install_regex}|.*/\1/"`
        ${install_cmd} ${id}
    done <${install_file}
}

# Update brew
brew update

# Install software
install ${base_dir}/software/brew-cask-list "brew cask install --appdir=/Applications" "(.*)"
install ${base_dir}/software/brew-list "brew install" "(.*)"
install ${base_dir}/software/mas-list "mas install" "([^ ]*).*"

# Cleanup
brew cleanup
brew cask cleanup
