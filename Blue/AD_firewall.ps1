#Author: Ali Alamri
#Course: Cyber Defense Technique
#Date: 08/29/2019
#Description: 1 powershell script that will configure the AD firewall rules 
#a Windows AD box is used for DNS, Group Policy, and LDAPauthentication. 
#Write firewall rules that allow clients to connect, authenticate, and resolvethrough this server. 



#Flush all firewall rule and removes all of the static local firewall rules.
Remove-NetFirewallRule 





#Because typing is hard 
Set-Alias -Name firewall -Value New-NetFirewallRule

#Allow ICMP traffic inbound for debugging usage

firewall -DesplayName "Allow inbound ICMP" -Direction  Inbound -Protocol ICMPv4 -IcmpType 8:0 -Action Allow
#Allow ICMP traffic outbound for debugging usage
firewall -DesplayName "Allow outbound ICMPv4" -Direction Outbound -Protocol ICMPv4 -IcmpType 0:8 -Action Allow

#Allow DNS quary inbound and outbound UDP
#53/TCP/UDP	DNS
firewall -DisplayName "Allow inbound DNS UDP" -Direction Inbound -Protocol UDP -LocalPort 53 -Action Allow
firewall -DisplayName "Allow outbound DNS UDP" -Direction Outbound -Protocol UDP -LocalPort 53 -Action Allow
#firewall -DisplayName "Allow inbound DNS TCP" -Direction Inbound -Protocol TCP -LocalPort 53 -Action Allow
 
#Ports needed for AD --> clients to connect, authenticate, and resolvethrough this server. 
#Allow RPC Endpoint Mapper, LDAP, Kerberos, LDAP SSL, SMB inbound TCP and UDP if needed
#########################################
#88/TCP/UDP	   Kerberos             #
#135/TCP	   RPC Endpoint Mapper  #
#137/TCP       NetBIOS for user auth    #
#138/UDP       NetBIOS for GPOs,logon   #
#139/TCP       NetBIOS Session          #
#389/TCP/UDP   LDAP                     #
#445/TCP	   SMB                  #
#636/TCP	   LDAP SSL             #
#########################################
firewall -DisplayName "Allow Kerberos, RPC, LDAP-LDAP/SSL SMB, NetBios inbound TCP" -Direction Inbound -Protocol TCP -LocalPort 88,135,137, 139,389,445,636 -Action Allow

firewall -DisplayName "Allow Kerberos, LDAP,  NetBios inbound UDP" -Direction Inbound -Protocol UDP -LocalPort 88,137,138,389 -Action Allow



#Block anytihng Else over TCP/UDP
firewall -DisplayName "Strict block over TCP" -Direction Inbound -Protocol TCP -LocalPort any -RemoteAddress any -Action Block

firewall -DisplayName "Strict block over UDP" -Direction Inbound -Protocol UDP -LocalPort any -RemoteAddress any -Action Block


#Show all firewall rules
#Get-NetFirewallRule -All
