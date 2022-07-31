## Oracle cloud always-free plan
- Two AMD Compute VMs (1/8 Core and 1 Gigabyte of RAM)
- Up to 4 instances of Arm Ampere A1 Compute (4 cores and 24 Gigabytes of RAM in total)
- 200 GB of Always Free block volume
- 0 NAT gateways

## Limitations
- Because NAT gateways are not free, you can't access public internet when your instance is in private VCN
- Minimum boot volume size is 50GB, so you can only create 4 instances regardless of the shape
- OKE(Oracle Kubernetes Engine) is not free, so you can't use oracle's load balancer in free-tier (alternatively, you can use metallb instead)

## The easiest way
- create only one instance with maximum resources
- use k3s for simplicity and performance (it also has it's own loadbalancer and ingress)

## instances
master-1:
  - Shape: VM.Standard.A1.Flex
  - OCPU: 4 
  - RAM: 24GB
  - Boot Storage: 200GB
  - In-transit encryption: Enabled
  - OS: Ubuntu

## k3s setup
```console
curl -sfL https://get.k3s.io | sh -
```

## k3s ingress setup
https://www.virtualizationhowto.com/2022/05/traefik-ingress-example-yaml-and-setup-in-k3s/

## https setup
use cloudflare

## helm setup (optional)
```console
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm repo add stable https://charts.helm.sh/stable
helm repo update
```
  
## Troubleshootings
- Q: Unable to access public internet from private network instances
- A: No solution as long as you are in free tier
- https://docs.oracle.com/en/learn/nat_gateway_private_compute_instance/index.html#configure-the-nat-gateway
- https://community.oracle.com/tech/apps-infra/discussion/4493649/unable-to-create-a-nat-gateway

## References
- https://medium.com/geekculture/how-to-create-an-always-free-k8s-cluster-in-oracle-cloud-60be3b107c44
- https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm
- https://loganmarchione.com/2022/03/k3s-single-node-cluster-for-noobs/
- https://si.mpli.st/dev/2020-01-01-easy-k8s-with-k3s/
- https://gruuuuu.github.io/cloud/l-helm-basic/
- https://pet2cattle.com/2022/07/install-helm-k3s
