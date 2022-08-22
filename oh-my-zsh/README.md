# ZSH

This folder contains zsh configuration.

The files here are tested with [oh-my-zsh](http://ohmyz.sh/), and may not work with "regular" zsh installations.

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
    * Enable completions
        https://github.com/zsh-users/zsh-completions
* Install theme: [PowerLevel10k](https://github.com/romkatv/powerlevel10k)
  * Using Oh My Zsh [Install](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
  * If using iTerm2, install `Meslo Nerd Font` with the `p10k configure` command.
