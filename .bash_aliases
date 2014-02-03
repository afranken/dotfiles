##################################################
## Modified commands ## {{{
alias grep='grep --color=auto'
alias more='less'
alias df='df -kh'
alias du='du -chs'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias vi='vim'
# }}}

##################################################
## New commands ## {{{
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias pgg='ps -Af | grep'           # requires an argument
alias varnishstart='launchctl load /usr/local/opt/varnish/homebrew.mxcl.varnish.plist'
# }}}

##################################################
## Make Bash error tolerant ## {{{
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias q='exit'
# }}}

##################################################
## Directory shortcuts ## {{{
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
# }}}

##################################################
## ls ## {{{
alias ls='ls -ahFG'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
# }}}

##################################################
## Safety features ## {{{
alias cp='cp -i'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -i'
# }}}

##################################################
## Git stuff # {{{
alias gitpull='git pull --rebase'
alias gitfetch='git fetch -p'
alias gitpush='git push'
alias gitci='git commit -a -m'
alias gita='git add'
alias gitb='git branch'
alias gitc='git checkout'
alias gitclean='git clean -fd'
alias gitstatus='git status -sb'
alias gitlog='git log --oneline --decorate'
alias gitdiff='git diff --word-diff'
alias gitblame='git blame -wMC' # -w ignores white space | -M ignores moving text | -C ignores moving text into other files
# }}}

###################################################
# Extract - extract most common compression types #
###################################################

function extract() {
  local e=0 i c
  for i; do
    if [[ -f $i && -r $i ]]; then
        c=''
        case $i in
          *.7z)  c='7z x'       ;;
          *.Z)   c='uncompress' ;;
          *.bz2) c='bunzip2'    ;;
          *.exe) c='cabextract' ;;
          *.gz)  c='gunzip'     ;;
          *.rar) c='unrar x'    ;;
          *.xz)  c='unxz'       ;;
          *.zip) c='unzip'      ;;
          *)     echo "$0: cannot extract \`$i': Unrecognized file extension" >&2; e=1 ;;
        esac
        [[ $c ]] && command $c "$i"
    else
        echo "$0: cannot extract \`$i': File is unreadable" >&2; e=2
    fi
  done
  return $e
}

####################################################################
# Mvn - add terminal-notifications                                 #
# see https://github.com/geoffreywiseman/maven-notification-center #
####################################################################

# Send a Notification to Notification Centre
function maven_notify {
	PROJECT=${PWD##*/}
	SUBTITLE="in $PROJECT"
	if [ $1 -eq 0 ]; then
		TITLE="Build Successful"
		MESSAGE="Build succeeded in $PROJECT; click to return."
	else
		TITLE="Build Failed"
		MESSAGE="Build failed in $PROJECT; click to return."
	fi
	activate_term_program
	terminal-notifier -title "$TITLE" -subtitle "$SUBITLE" -message "$MESSAGE" -group $PROJECT $SENDER
}

# Set the 'ACTIVATE' variable based on the terminal in which this is running
function activate_term_program {
	if [ $TERM_PROGRAM = "Apple_Terminal" ]; then
		SENDER="-sender com.apple.Terminal"
	elif [ $TERM_PROGRAM = "iTerm.app" ]; then
		SENDER="-sender com.googlecode.iterm2"
	else
		SENDER=""
	fi
}

#re-register mvn
alias maven="command mvn"
notified_maven() {
  # only run terminal-notifier if it exists
  if hash terminal-notifier 2>/dev/null; then
    NOTIFY=1
  fi

  if [ -n "$NOTIFY" ];
    then
      maven $*
      maven_notify $?
    else
      maven $*
  fi

}
alias mvn=notified_maven
