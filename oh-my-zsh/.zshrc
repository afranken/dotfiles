export DOTFILES_PATH=~/.dotfiles
export ZSH_SRC_PATH=${DOTFILES_PATH}/oh-my-zsh

#read local includes
for file in ${DOTFILES_PATH}/local/.*-local
do
  source ${file}
done

source ${DOTFILES_PATH}/bash/.aliases
source ${DOTFILES_PATH}/bash/.functions
source ${DOTFILES_PATH}/bash/.functions-osx

alias mcist="mvn clean install -DskipTests"

# insert /usr/local/bin before /usr/bin in order to overwrite system commands with homebrew commands
# also insert /usr/local/sbin
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export IDEA_JDK=$(/usr/libexec/java_home)

# configure Maven
export M2_HOME=/usr/local/opt/maven/libexec
export M2=/usr/local/opt/maven/libexec
