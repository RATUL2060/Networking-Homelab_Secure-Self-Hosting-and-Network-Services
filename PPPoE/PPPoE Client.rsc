# 2026-01-05 23:38:46 by RouterOS 7.18.2
# system id = GhzPTnbOBkK
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 name=pppoe-out1 \
    use-peer-dns=yes user=user3
/port
set 0 name=serial0
set 1 name=serial1
/ip dhcp-client
add interface=ether1
/system identity
set name=CLIENT
/system note
set show-at-login=no
