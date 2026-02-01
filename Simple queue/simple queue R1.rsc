# 2026-01-10 16:38:44 by RouterOS 7.18.2
# system id = drYuPe6jbRH
#
/interface bridge
add name=bridge-lan
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-wan
set [ find default-name=ether2 ] disable-running-check=no name=ether2-R2
set [ find default-name=ether3 ] disable-running-check=no name=ether3-pc
/ip pool
add name=pool1 ranges=10.60.60.2-10.60.60.254
/port
set 0 name=serial0
set 1 name=serial1
/queue simple
add max-limit=2M/2M name=queue2 target=192.168.88.3/32
add max-limit=1M/1M name=queue1 target=""
/interface bridge port
add bridge=bridge-lan interface=ether2-R2
add bridge=bridge-lan interface=ether3-pc
/interface pppoe-server server
# Service is on a slave interface
add default-profile=default-encryption disabled=no interface=ether2-R2 \
    service-name=PPPoE-LAB
/ip address
add address=192.168.88.1/24 interface=bridge-lan network=192.168.88.0
/ip dhcp-client
add interface=ether1-wan
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-wan
/system identity
set name=pool-PPPOE
/system note
set show-at-login=no
