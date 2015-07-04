dotfiles
==========

This repository contains configuration and installation scripts for **OSX Mavericks**.
I develop Java and JavaScript applications with GIT, Maven, Node and Grunt, all configuration and software is tailored around that.

if Git is already installed,
_Checkout workspace to `~/.dotfiles/`_

otherwise

_download ZIP, unpack to `~/.dotfiles`_, install all desired software. 

After installing GIT, to sync the local repo with the remote, do:

    cd ~/.dotfiles
    git init
    git remote add origin https://github.com/afranken/dotfiles.git
    git fetch
    git reset --hard origin/master
    git branch -u origin/master

There is a `*-bootstrap.sh` script in most folders, **take a look at each script before executing it. (!)**


Run scripts in this order:

1. `brew/`: homebrew configuration and installation scripts. Next steps rely on software installed here.
2. `git/` : git configuration.
3. `bash/`: profile, functions, aliases.
4. `osx/` : osx configuration
