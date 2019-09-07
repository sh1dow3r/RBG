#!/bin/bash
#Author: Ali Alamri
#Course: Cyber Defense Technique
#Date: 08/29/2019
#Description: bash script that will configure Gitlab firewall rules

#server_ip
SERVER_IP="$(ip addr show eth0 | grep 'inet ' | cut -f2 | awk '{ print $2}')"

#alias for less typeing 
ip=iptables 

#Flush All the tables(default "F" and non-default chain "X") to make sure only our firewall rule existed
$ip -F
$ip -X
$ip -t nat -F
$ip -t nat -X
$ip -t mangle -F
$ip -t mangle -X

#Allow ICMP protocol out for debugging usage
#ICMP-TYPE 8 is Echo, and 0 is Echo-Replay
$ip -A INPUT -p ICMP --icmp-type 8 -j ACCEPT
$ip -A OUTPUT -p ICMP --icmp-type 0 -j ACCEPT

#Allow ICMP protocol in for debugging usage 
#$ip -A OUTPUT -p ICMP --icmp-type 8 -j ACCEPT
#$ip -A INPUT -p ICMP --icmp-type 0 -j ACCEPT

#Allow DNS quireies 
$ip -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
$ip -A INPUT  -p udp --sport 53 -m state --state ESTABLISHED     -j ACCEPT
$ip -A OUTPUT -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
$ip -A INPUT  -p tcp --sport 53 -m state --state ESTABLISHED     -j ACCEPT

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#Gitlab Firewall rule (22 for SSH, 80 and 443 for WebTraffic, 9418 for GIT 
iptables -A INPUT  -p tcp -m multiport --dports 22,80,443,9418 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 22,80,443,9418 -m state --state ESTABLISHED -j ACCEPT



#Deafult drop 
$ip -A INPUT -j DROP
$ip -A OUTPUT -j DROP

#FOR TESTING PURPOSES
#SLEEP 5 && $ip -F &
