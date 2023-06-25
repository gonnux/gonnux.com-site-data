Generate private/public key pair for master and worker nodes
```bash
$ umask 077
$ wg genkey > privatekey
$ wg pubkey < privatekey > publickey
```

Master node /etc/wireguard/wg0.conf
```text
[Interface]
#SaveConfig = true
Address = 192.168.1.1/24
PrivateKey = <MASTER NODE PRIVATE KEY>
DNS = 8.8.8.8
ListenPort = 55555
PostUp = /etc/wireguard/helpers/add-nat-routing.sh
PostDown = /etc/wireguard/helpers/remove-nat-routing.sh

[Peer]
PublicKey = <WORKER1 NODE PUBLIC KEY>
AllowedIPs = 192.168.1.2/32

[Peer]
PublicKey = <WORKER2 NODE PUBLIC KEY>
AllowedIPs = 192.168.1.3/32
```

Master node add-nat-routing.sh
```bash
#!/bin/bash
IPT="/sbin/iptables"
#IPT6="/sbin/ip6tables"

IN_FACE="enp0s3"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC
SUB_NET="192.168.1.0/24"          # WG IPv4 sub/net aka CIDR
WG_PORT="55555"                  # WG udp port
#SUB_NET_6="fd42:42:42::/64"      # WG IPv6 sub/net

## IPv4 ##
$IPT -t nat -I POSTROUTING 1 -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -I INPUT 1 -i $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -I INPUT 1 -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT

## IPv6 (Uncomment) ##
#$IPT6 -t nat -I POSTROUTING 1 -s $SUB_NET_6 -o $IN_FACE -j MASQUERADE
#$IPT6 -I INPUT 1 -i $WG_FACE -j ACCEPT
#$IPT6 -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
#$IPT6 -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
```

Master node remove-nat-routing.sh
```bash
#!/bin/bash
IPT="/sbin/iptables"
#IPT6="/sbin/ip6tables"

IN_FACE="enp0s3"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC
SUB_NET="192.168.1.0/24"          # WG IPv4 sub/net aka CIDR
WG_PORT="55555"                  # WG udp port
#SUB_NET_6="fd42:42:42::/64"      # WG IPv6 sub/net

# IPv4 rules #
$IPT -t nat -D POSTROUTING -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -D INPUT -i $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -D INPUT -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT

# IPv6 rules (uncomment) #
#$IPT6 -t nat -D POSTROUTING -s $SUB_NET_6 -o $IN_FACE -j MASQUERADE
#$IPT6 -D INPUT -i $WG_FACE -j ACCEPT
#$IPT6 -D FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
#$IPT6 -D FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
```

Worker1 node /etc/wireguard/wg0.conf

```text
[Interface]
PrivateKey = <WORKER1 NODE PRIVATE KEY>
Address = 192.168.1.2/24
ListenPort = 51822
DNS = 8.8.8.8

[Peer]
PublicKey = <MASTER NODE PUBLIC KEY>
EndPoint = master-1.gonnux.com:55555 # You can also use ip address instead of domain address
# AllowedIps = 192.168.1.0/24 # This allows the worker to access to 192.168.1.* addresses through VPN, The worker still can connect to the public internet, but not through VPN
AllowedIps = 0.0.0.0/0, ::/0 # This allows the worker to access to the public internet through VPN
```

Activate wireguard from both side using this command
```bash
wg-quick up wg0
```

https://prog.world/free-oracle-cloud-servers-mikrotik-site-to-site-vpn/
https://learnoci.cloud/how-to-create-a-site-to-site-vpn-between-oracle-cloud-infrastructure-and-ubiquity-dream-machine-908353a51bd3

https://serverfault.com/questions/1076995/routing-only-the-private-network-in-wireguard-vpn
https://www.reddit.com/r/WireGuard/comments/lsccq8/link_2_separate_networks_using_wireguard_and_linux/
https://github.com/mjtechguy/wireguard-site-to-site
https://www.procustodibus.com/blog/2020/12/wireguard-site-to-site-config/
https://ziwon.github.io/post/wireguard/
https://www.reddit.com/r/WireGuard/comments/fo6czc/wireguard_service_wont_start_on_ubuntu_after/
