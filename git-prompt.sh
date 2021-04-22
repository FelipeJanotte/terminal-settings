if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;Git-Bash: ${PWD//[^[:ascii:]]/?}\007\]' 	# set window title
	PS1="$PS1"'\n'                 													# new line
	PS1="$PS1"'\033[36m\u'       														# change color to cyan + User
	PS1="$PS1"'\033[1;37m in'	      												# change to gray + 'in'
	# PS1="$PS1"'$MSYSTEM '          												# show MSYSTEM
	PS1="$PS1"'\033[32m ../\W'       												# change to magenta + current directory
	# PS1="$PS1"'\d \@ '																		# show the date (week/month/day)
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\033[1;35m `__git_ps1`'  														# change color to magenta bold + bash function
		fi
	fi
	PS1="$PS1"'\033[m'        																					# change color to default
	PS1="$PS1"'\n'                 																			# new line
	PS1="$PS1"'❱ '                 																			# prompt: always ❱
fi

MSYS2_PS1="$PS1"               																				# for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
