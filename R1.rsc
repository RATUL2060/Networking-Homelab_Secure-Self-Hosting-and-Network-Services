# 2025-12-22 12:10:40 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-wan
set [ find default-name=ether2 ] disable-running-check=no name=ether2-lan
/port
set 0 name=serial0
set 1 name=serial1
/user group
add name=junior policy="read,test,winbox,password,!local,!telnet,!ssh,!ftp,!re\
    boot,!write,!policy,!web,!sniff,!sensitive,!api,!romon,!rest-api"
/ip address
add address=192.168.88.1/24 interface=ether2-lan network=192.168.88.0
/ip dhcp-client
add default-route-tables=main interface=ether1-wan
/ip dns
set allow-remote-requests=yes
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan src-address=\
    192.168.88.0/24
/ip service
set ftp disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system note
set show-at-login=no
