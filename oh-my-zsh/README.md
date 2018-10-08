#ZSH

This folder contains zsh configuration.

The files here are tested with [oh-my-zsh](http://ohmyz.sh/), and may not work with "regular" zsh installations.

[Nerd-Font](https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#option-4-install-nerd-fonts) is already installed if [install.sh](../software/install.sh) was executed, configure iTerm to use it.

* `zsh-bootstrap.sh` : install oh-my-zsh
* Edit `~/.zshrc` (unfortunately this can't be automated or outsourced to a separate file) 
    * Enable separate custom folder:
        ```
        # Would you like to use another custom folder than $ZSH/custom?
        ZSH_CUSTOM=~/.dotfiles/oh-my-zsh/custom
        ```
    * Enable plugins for command completion:
        ```
        plugins=(git mvn docker)
        ```
