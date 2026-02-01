# 2026-01-05 21:59:12 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1---wan
set [ find default-name=ether2 ] disable-running-check=no name=ether2-lan
/port
set 0 name=serial0
set 1 name=serial1
/ppp profile
set *FFFFFFFE local-address=10.40.40.1 remote-address=10.40.40.2
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set enabled=yes
/interface sstp-server server
set certificate=Server_template enabled=yes
/ip address
add address=192.168.2.1/24 interface=ether2-lan network=192.168.2.0
/ip route
add disabled=no dst-address=192.168.2.0/24 gateway=10.10.10.2 routing-table=\
    main suppress-hw-offload=no
/ppp secret
add local-address=10.40.40.1 name=user2 profile=default-encryption \
    remote-address=10.40.40.2 service=sstp
/system clock
set time-zone-name=Asia/Dhaka
/system identity
set name=HQ
/system note
set show-at-login=no
/system ntp client
set enabled=yes
/system ntp client servers
add address=pool.ntp.org
