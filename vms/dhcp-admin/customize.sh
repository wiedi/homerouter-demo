# dhcp-admin

pkgin -y install isc-dhcpd nano

sed -i s_/var/db/isc-dhcp_/var/run/isc-dhcp_g /opt/local/lib/svc/method/isc-dhcpd
rm -r /var/run/isc-dhcp/

cat > /opt/local/etc/dhcp/dhcpd.conf << EOF
option domain-name-servers 192.168.10.53;
option domain-name "f.fruky.net";
ddns-update-style none;
authoritative;
default-lease-time 3600;
max-lease-time 4000;
use-host-decl-names on;
lease-file-name "/var/run/isc-dhcp/dhcpd.leases";

subnet 192.168.15.0 netmask 255.255.255.0 {
  option routers 192.168.15.1;
  option subnet-mask 255.255.255.0;
  range 192.168.15.100 192.168.15.250;
}

# .1   gw
# .2   dhcp
host light      { fixed-address 192.168.15.4;  hardware ethernet b8:27:eb:d5:1d:35; }
# .5   apu gz static
# .8   switch-office
# .9   switch-dc
# ...
host stor-sw    { fixed-address 192.168.15.61; hardware ethernet b2:98:b5:6b:5a:b6; }
# ...

EOF

svcadm enable isc-dhcpd
svcadm restart isc-dhcpd
