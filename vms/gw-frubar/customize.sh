# gw-frubar

pkgin -y install openvpn nano mtr

cat > /opt/local/etc/openvpn/openvpn.conf << "EOF"
# put openvpn config file here
# and enable redirect-gateway ipv6 !ipv4
EOF

routeadm -ue ipv4-forwarding
routeadm -ue ipv6-forwarding

route -p add -inet6 2a01:138:a015:15::/64 2a01:138:a015:35::2
route -p add -inet6 2a01:138:a015:10::/64 2a01:138:a015:35::2

svcadm enable openvpn
svcadm clear openvpn # should be fixed with new smf manifest
