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
	if [ $1 ]; then
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
  maven $*

  # only run terminal-notifier if it exists
  if hash terminal-notifier 2>/dev/null; then
      maven_notify $?
  fi
}
alias mvn=notified_maven
