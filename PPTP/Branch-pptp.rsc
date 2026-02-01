# 2026-01-04 19:58:02 by RouterOS 7.18.2
# system id = GhzPTnbOBkK
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no name=ether2-lan
/interface list
add name=WAN
add name=LAN
/ip pool
add name=vpn ranges=192.168.89.2-192.168.89.255
/port
set 0 name=serial0
set 1 name=serial1
/ppp profile
add local-address=10.10.10.2 name=pptp-client-profile remote-address=\
    10.10.10.1 use-encryption=yes
set *FFFFFFFE local-address=192.168.89.1 remote-address=vpn
/interface pptp-client
add connect-to=192.168.12.1 disabled=no name=pptp-to-HQ profile=\
    pptp-client-profile user=user1
/interface l2tp-server server
set enabled=yes use-ipsec=yes
/interface list member
add interface=ether1 list=WAN
add interface=ether2-lan list=LAN
/ip address
add address=192.168.2.1/24 interface=ether2-lan network=192.168.2.0
add address=192.168.12.2/24 interface=ether1 network=192.168.12.0
/ip dhcp-client
add interface=ether1
/ip firewall filter
add action=accept chain=forward comment="ALLOW HQ LAN to Branch LAN" \
    dst-address=192.168.2.0/24 src-address=192.168.1.0/24
/ip firewall nat
add action=masquerade chain=srcnat comment="masq. vpn traffic" src-address=\
    192.168.89.0/24
add action=accept chain=srcnat comment="NO NAT HQ \? Branch over PPTP" \
    dst-address=192.168.2.0/24 src-address=192.168.1.0/24
/ip route
add disabled=no dst-address=192.168.1.0/24 gateway=10.10.10.1 routing-table=\
    main suppress-hw-offload=no
/ppp secret
add name=vpn
/system identity
set name=BRANCH
/system note
set show-at-login=no
