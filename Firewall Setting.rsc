# 2026-01-02 13:32:51 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-wan
set [ find default-name=ether2 ] disable-running-check=no name=ether2-lan
/ip pool
add name=dhcp_pool0 ranges=192.168.12.2-192.168.12.254
/port
set 0 name=serial0
set 1 name=serial1
/ip address
add address=192.168.12.1/24 interface=ether2-lan network=192.168.12.0
/ip dhcp-client
add interface=ether1-wan
/ip dhcp-server network
add address=192.168.12.0/24 gateway=192.168.12.1
/ip firewall filter
add action=accept chain=forward connection-state=established,related,new \
    in-interface=ether2-lan
add action=accept chain=input connection-state=established,related,new
add action=drop chain=forward connection-state=invalid
add action=drop chain=input connection-state=invalid
add action=accept chain=forward connection-state=established,related,new \
    src-address=192.168.12.11
add action=drop chain=forward
add action=accept chain=input dst-port=8291 protocol=tcp src-address=\
    192.168.12.11
add action=drop chain=input dst-port=8291 protocol=tcp
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan
/ip service
set ftp disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system note
set show-at-login=no
/tool mac-server mac-winbox
set allowed-interface-list=none
