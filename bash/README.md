#BASH

This folder contains bash configuration.

The files here are compatible with OSX, Linux and Windows (with [Cygwin](https://www.cygwin.com/)), but are tested
regulary only on OSX.

* `bash-bootstrap.sh` : link `.profile` to `~/.profile`
* `.profile` : this file is loaded by every interactive shell when linked to `~/.profile`. 
  
  Other files in this folder are loaded from the profile. It also contains shell independent configuration. 
  Before loading other files, `*-local` files are loaded from [the local folder](../local/) where System Variables may need to be set in order for other programs to work. (e.g. Git Username or email)
  
* `.bashrc` : contains bash configuration
* `.bash_completion` : contains a function that completes all aliased commands
* `.aliases` : contains useful aliases available in the shell
* `.functions` : contains commands too complex for simple aliases.
* `.profile-osx` : contains OSX specific, but shell independent configuration
* `.bashrc-osx` : contains OSX specific bash configuration
* `.aliases-osx` : contains OSX specific useful aliases available in the shell
* `.functions-osx` : contains OSX specific commands too complex for simple aliases.
* `.functions-linux` : contains Linux specific commands too complex for simple aliases.

Useful description of Bash commands:
---------
https://github.com/jlevy/the-art-of-command-line
