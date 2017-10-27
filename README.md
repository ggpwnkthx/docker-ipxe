# docker-ipxe
## About
This is a super easy to use Docker container that will allow you to load the latest version of iPXE on devices that only have PXE support in both BIOS and EFI modes. Once iPXE loads, it will chain load the boot path you provide.
## How To Use
```bash
sudo ./start.sh [interface] [boot_path]
```
Example:
```bash
sudo ./start.sh eth0 "http://boot.netboot.xyz/"
```
## Details
This alpine:edge Docker container uses DNSMasq. It is NOT set up to lease IP addresses. It IS set to use proxyDHCP. If you are not familiar with proxyDHCP, what this means is that it will not interupt any other DHCP server on the network. It will ONLY pass PXE instructions.

The start.sh script is designed to help automate the start-up process. By giving it an interface, it will figure out the subnet it needs be working within and will force DNSMasq to only uses that interface. This means you can run multiple instances of this container on different interfaces if needed.

The Docker build process will run each time start.sh is called. So, if you choose to make any changes to the pxe.conf file, these changes will be pulled over each time.

ROM-o-matic.eu is used to build the iPXE binary BIOS, x86 EFI, and x64 EFI files. All of the files have the exact same feature to make sure there is consistancy among all devices that boot from this Docker container.

Keep in mind, the start.sh script will kill and remove any verions of itself running on the same interface to prevent errors.

## iPXE Features
* DNS
* FTP
* HTTP
* HTTPS
* iSCSI
* NFS
* SLAM
* TFTP
* FCoE
* SRP
* VLAN
* AoE
* ELF
* MBOOT
* PXE
* bzImage
* Menu
* PXEXT
