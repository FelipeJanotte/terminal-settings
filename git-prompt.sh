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
	PS1='\[\033]0;Git-Bash: ${PWD//[^[:ascii:]]/?}\007\]' 					
	# set window title
	
	PS1="$PS1"'\n'                 												
	# new line
	PS1="$PS1"'\033[1;36m\u '       														
	# change font to cyan + show CurrentUser 
	
	PS1="$PS1"'\033[4;37min'	      													
	# change font to gray + show 'in'
	
	PS1="$PS1"'\033[0;32m ../\W'       												
	# change font to purple + show CurrentDirectory
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
			PS1="$PS1"'\033[1;36m `__git_ps1`'  														
			# change font to magenta bold + bash function
		fi
	fi
	PS1="$PS1"'\033[m'        															
	# change font to default
	PS1="$PS1"'\n'																			
	# new line
	PS1="$PS1"'\v '																		
	# show bash version
	PS1="$PS1"'➤  '                 													
	# prompt: ➤
fi

MSYS2_PS1="$PS1"               														
# for detection by MSYS2 SDK's bash.basrc

# evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi

# MORE

# * PS1="$PS1"'\n'
	# ? new line

# * PS1="$PS1"'\d'																	
	# ? show the date (week/month/day)

# * PS1="$PS1"'\@ '																		
	# ? show the time (12-hour am/pm)

# * PS1="$PS1"'\A '
	# ? show the time (24-hour HH:MM)

# * PS1="$PS1"'\t '
	# ? show the time (24-hour HH:MM:SS)

# * PS1="$PS1"'\T '
	# ? show the time (12-hour HH:MM:SS)

# * PS1="$PS1"'\033[m'
	# ? change color
		# ? \033[30m' - BLACK
		# ? \033[31m' - RED
		# ? \033[32m' - GREEN
		# ? \033[33m' - BROWN
		# ? \033[34m' - BROWN
		# ? \033[35m' - PURPLE
		# ? \033[36m' - CYAN
		# ? \033[37m' - WHITE

# * PS1="$PS1"'\u '
	# ? show current username

# * PS1="$PS1"'\h '
	# ? show the hostname
# * PS1="$PS1"'\H '
	# ? show fully domain name
 
# * PS1="$PS1"'\W '
	# ? show current working directory

# * PS1="$PS1"'\v '
	# ? show bash version

# * PS1="$PS1"'\V '
	# ? show bash version + patch

# * PS1="$PS1"'\! '
	# ? show history number of command

# * PS1="$PS1"'\# '
	# ? show command number


