#Author: Ali Alamri
#Course: Cyber Defense Technique
#Date: 08/29/2019
#Description: 1 powershell script that will configure the AD firewall rules
"Windows AD is a critical component in most enterprise environments. 
In the small hypotheticaltopology you are given, a Windows AD box is used for DNS, Group Policy, and LDAPauthentication. Write firewall rules that allow clients to connect, authenticate, and resolvethrough this server. 
You will need to research which ports and protocols are required for theseservices to remain up within the network.
Your output should be a powershell script that will create the rules for you. Look into the cmdlet“New-NetFirewallRule” to start writing the firewall. 
This script should handle both ingress andegress"


#Because typing is hard 
Set-Alias -Name firewall -Value New-NetFirewallRule

#Allow ICMP traffic for debugging usage
firewall -DesplayName "Allow inbound ICMPv4" -Direction  Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
firewall -DesplayName "Allow outbound ICMPv4" -Direction Outbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
firewall -DisplayName "Allow inbound ICMPv6" -Direction Inbound -Protocol ICMPv6 -IcmpType 8 -Action Allow
firewall -DisplayName "Allow outbound ICMPv6" -Direction Outbound -Protocol ICMPv6 -IcmpType 0 -Action Allow
























soureces: https://devops.ionos.com/tutorials/managing-the-windows-2012-r2-firewall-with-powershell/
