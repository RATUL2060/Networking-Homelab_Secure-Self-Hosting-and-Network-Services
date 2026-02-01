# 2026-01-05 23:39:05 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-wan
set [ find default-name=ether2 ] disable-running-check=no name=\
    "ether2-pppoe server"
/ip pool
add name=pool1 ranges=10.60.60.2-10.60.60.254
/port
set 0 name=serial0
set 1 name=serial1
/ppp profile
add change-tcp-mss=yes dns-server=8.8.8.8,1.1.1.1 local-address=10.60.60.1 \
    name=PPPoE-profile rate-limit=1M/1M remote-address=pool1
/interface pppoe-server server
add default-profile=default-encryption disabled=no interface=\
    "ether2-pppoe server" service-name=PPPoE-LAB
/ip dhcp-client
add interface=ether1-wan
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan
/ppp secret
add local-address=0.0.0.0 name=user3 profile=PPPoE-profile service=pppoe
/system identity
set name=pool-PPPOE
/system note
set show-at-login=no
