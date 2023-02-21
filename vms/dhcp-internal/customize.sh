# dhcp-internal

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

subnet 192.168.10.0 netmask 255.255.255.0 {
  option routers 192.168.10.1;
  option subnet-mask 255.255.255.0;
  range 192.168.10.100 192.168.10.250;
}

# .53 DNS

EOF

svcadm enable isc-dhcpd
