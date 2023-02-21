# gw-f15

pkgin -y install mtr nano

cat > /etc/ipf/ipf.conf << EOF
pass in  quick on lo0 all
pass out quick on lo0 all

# net0
pass in  on net0 all
pass out on net0 all

# net1
pass in  quick on net1 all
pass out quick on net1 all

# net2
pass in  quick on net2 proto tcp from any to any flags S keep state
pass in  quick on net2 proto udp from any to any         keep state

pass out quick on net2 proto tcp from 192.168.0.0/16 to any flags S keep state
pass out quick on net2 proto udp from 192.168.0.0/16 to any         keep state

pass in  quick on net2 proto icmp
pass out quick on net2 proto icmp

block out quick on net2 all
EOF

cat > /etc/ipf/ipf6.conf << EOF
pass in  quick on lo0 all
pass out quick on lo0 all

# net0
pass in  on net0 all
pass out on net0 all

# net1
pass in  quick on net1 all
pass out quick on net1 all

# net2
pass in  quick on net2 proto tcp from any to any flags S keep state
pass in  quick on net2 proto udp from any to any         keep state

pass out quick on net2 proto tcp from 2a01:138:a015::/48 to any flags S keep state
pass out quick on net2 proto udp from 2a01:138:a015::/48 to any         keep state

pass in  quick on net2 proto ipv6-icmp
pass out quick on net2 proto ipv6-icmp

block out quick on net2 all
EOF


cat > /etc/inet/ndpd.conf << EOF
ifdefault AdvSendAdvertisements 0
ifdefault StatelessAddrConf 0
ifdefault StatefulAddrConf 0
prefixdefault AdvOnLinkFlag on AdvAutonomousFlag on

if net1 AdvSendAdvertisements 1
prefix 2a01:138:a015:15::/64 net1
if net2 AdvSendAdvertisements 1
prefix 2a01:138:a015:10::/64 net2
EOF

routeadm -ue ipv4-forwarding
routeadm -ue ipv6-forwarding

route -p add -inet6 default 2a01:138:a015:35::3

svcadm enable ipfilter
svcadm enable ndp	# fixed by OS-5054 joyent-minimal should import ndp by default #427?