# 2026-01-10 16:39:08 by RouterOS 7.18.2
# system id = GhzPTnbOBkK
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
/port
set 0 name=serial0
set 1 name=serial1
/ip address
add address=192.168.88.3/24 interface=ether1 network=192.168.88.0
/ip dhcp-client
add interface=ether1
/ip route
add dst-address=0.0.0.0/0 gateway=192.168.18.1
add dst-address=0.0.0.0/0 gateway=192.168.88.1
/system identity
set name=CLIENT
/system note
set show-at-login=no
