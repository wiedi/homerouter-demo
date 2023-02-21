# dns

pkgin -y install unbound nano mtr

cat > /opt/local/etc/unbound/unbound.conf << EOF
server:
  verbosity: 0
  interface: 0.0.0.0
  interface: ::0
  interface-automatic: yes
  access-control: ::0/0 allow
  access-control: 0.0.0.0/0 allow
remote-control:
  control-enable: yes
EOF

unbound-control-setup

svcadm enable svc:/pkgsrc/unbound:default

# workaround ndp spam
echo 'ifdefault StatelessAddrConf off' > /etc/inet/ndpd.conf
