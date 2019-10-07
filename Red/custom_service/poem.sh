#!/bin/bash

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

