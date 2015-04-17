#!/bin/sh
#taken from https://gist.github.com/c00kiemon5ter/3730069b6c920841a3ca

help=0
latest=0
verbose=0
status=0

usage() {
	cat <<-EOF
	${0##*/} [options]

	  options:
	    -h  show help dialog
	    -l  reinstall packages with version "latest"
	    -v  verbose output
	EOF
	exit "$status"
}

for opt
do case "$opt" in
	'-h') usage ;;
	'-l') latest=1 ;;
	'-v') verbose=1 ;;
	*) status=1 usage ;;
esac
done

set -- $(brew cask list)
sentinel='/'

oldIFS="$IFS"
IFS="$sentinel"
apps="$sentinel$*$sentinel"
IFS="$oldIFS"

for appdir in /opt/homebrew-cask/Caskroom/*
do
	[ -d "$appdir" ] || continue
	app="${appdir##*/}"

	verlocal="$(find "$appdir"/* -type d -print -quit)"
	verlocal="${verlocal##*/}"
	verlatest="$(brew cask info "$app" | awk -v app="$app" '$1 == app":" { print $2; exit }')"

	case "$apps" in
		*"$sentinel$app$sentinel"*)
			if [ "$verbose" -ne 0 ]
			then
				printf -- ':: found app: %s\n' "$app"
				printf -- 'local  version: %s\n' "$verlocal"
				printf -- 'latest version: %s\n' "$verlatest"
			fi
			if [ "$latest" -ne 0 ] && [ "$verlocal" = 'latest' ] || [ "$verlocal" != "$verlatest" ]
			then brew cask install --force "$app" && [ "$verlocal" != "$verlatest" ] && rm -rf "$appdir/$verlocal"
			fi
			;;
		*)
			printf -- 'app not found: %s\n' "$app"
			status=1
			;;
	esac
done

exit "$status"
