# docker-ipxe
## How To Use
```bash
sudo ./start.sh [interface] [boot_path]
```
Example:
```bash
sudo ./start.sh eth0 "http://boot.netboot.xyz/"
```
## About
This alpine:edge Docker container uses DNSMasq. It is NOT set up to lease IP addresses. It IS set to use proxyDHCP. If you are not familiar with proxyDHCP, what this means is that it will not interupt any other DHCP server on the network. It will ONLY pass PXE instructions.

The start.sh script is designed to help automate the start-up process. By giving it an interface, it will figure out the subnet it needs be working within and will force DNSMasq to only uses that interface. This means you can run multiple instances of this container on different interfaces if needed.
