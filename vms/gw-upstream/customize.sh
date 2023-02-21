# gw-upstream

echo 'map net1 192.168.0.0/16 -> 0/32 portmap tcp/udp 1025:65534' >  /etc/ipf/ipnat.conf
echo 'map net1 192.168.0.0/16 -> 0/32'                            >> /etc/ipf/ipnat.conf

svcadm enable ipfilter

routeadm -ue ipv4-forwarding

route -p add -inet6 2a01:138:a015:15::/64 2a01:138:a015:35::2
route -p add -inet6 2a01:138:a015:10::/64 2a01:138:a015:35::2
route -p add -inet6 default               2a01:138:a015:35::3
