# Homerouter Demo

Creating my illumos based homerouter on a PC-ENGINES APU.

Always work in progress.

## Networks

```
vlan	ipv4				ipv6						name
----------------------------------------------------------------
0		192.168.15.0/24		2a01:138:a015:15::/64		admin
2		192.168.10.0/24		2a01:138:a015:10::/64		internal
3		10.??.??.??/??		2???::/64					freifunk
0		192.168.35.0/24		2a01:138:a015:35::/64		routing0
```

## Nictags

APU nictags:

- uplink
- admin
- aux
- routing0 (etherstub)

vlans:

- internal = admin + vlan2
- freifunk = admin + vlan3
	
