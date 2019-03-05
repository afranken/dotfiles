export DOTFILES_PATH=~/.dotfiles
export SHELLS_SRC_PATH=${DOTFILES_PATH}/all_shells

source ${SHELLS_SRC_PATH}/.profile

#just dummy values to make the AWS-SDK happy during local tests.
export AWS_ACCESS_KEY_ID=NONE
export AWS_SECRET_KEY=NONE
