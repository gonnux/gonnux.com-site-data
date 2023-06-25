Generate private/public key pair for master and worker nodes
```bash
$ umask 077
$ wg genkey > privatekey
$ wg pubkey < privatekey > publickey
```

Master Node /etc/wireguard/wg0.conf
```
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

Worker1 Node /etc/wireguard/wg0.conf
```
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
