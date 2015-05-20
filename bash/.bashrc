##Bash configuration

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

shopt -s histappend                             # append to the history file, don't overwrite it
shopt -s cmdhist                                # save multi-line commands in history as single line

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a'
export HISTIGNORE='&:bg:fg:ll:history'

set -o notify                                   # notify when jobs running in background terminate
set -b                                          # causes output from background processes to be output right away, not on wait for next primary prompt
shopt -s cdspell                                # this will correct minor spelling errors in a cd command
shopt -s histappend histreedit histverify       # bash history is only saved when close terminal, not after each command and this fixes it
shopt -s no_empty_cmd_completion                # no empty completion (bash>=2.04 only)

if [ "$TERM" = "screen" ]; then
    export TERM=$TERMINAL
fi

###### This is a 'universal' completion function - it works when commands have
# a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
# Needs the '-o' option of grep
# (try the commented-out version if not available).
# First, remove '=' from completion word separators
# (this will allow completions like 'ls --color=auto' to work correctly).
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}

# complete all aliases
if [ -f .bash_completion ]; then
    source .bash_completion
fi
