# 2026-01-04 19:59:42 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=\
    ether1---Branch
set [ find default-name=ether2 ] disable-running-check=no name=ether2-lan
/port
set 0 name=serial0
set 1 name=serial1
/ppp profile
add local-address=10.10.10.1 name=pptp-site2site remote-address=10.10.10.2 \
    use-encryption=yes
add local-address=10.10.10.1 name=pptp-s2s only-one=yes remote-address=\
    10.10.10.2 use-encryption=yes
set *FFFFFFFE local-address=10.10.10.1 remote-address=10.10.10.2
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set enabled=yes
/ip address
add address=192.168.1.1/24 interface=lo network=192.168.1.0
add address=192.168.12.1/24 interface=ether1---Branch network=192.168.12.0
/ip dhcp-client
add interface=ether1---Branch
/ip firewall filter
add action=accept chain=forward comment="ALLOW Branch LAN to HQ LAN" \
    dst-address=192.168.1.0/24 src-address=192.168.2.0/24
add action=accept chain=input comment="ALLOW ICMP from Branch LAN" protocol=\
    icmp src-address=192.168.2.0/24
add action=accept chain=input comment="ALLOW ICMP from PPTP tunnel" protocol=\
    icmp src-address=10.10.10.0/30
add action=accept chain=input comment="ALLOW ICMP from management PC subnet" \
    protocol=icmp src-address=192.168.12.0/24
/ip firewall nat
add action=accept chain=srcnat comment="NO NAT Branch \? HQ over PPTP" \
    dst-address=192.168.1.0/24 src-address=192.168.2.0/24
/ip route
add disabled=no dst-address=192.168.2.0/24 gateway=10.10.10.2 routing-table=\
    main suppress-hw-offload=no
/ppp secret
add local-address=10.10.10.1 name=user1 profile=pptp-s2s remote-address=\
    10.10.10.2 service=pptp
/system identity
set name=HQ
/system note
set show-at-login=no
