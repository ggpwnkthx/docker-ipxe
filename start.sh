#!/bin/bash
if [ -z $1 ]
then
        echo "No interfece name given."
        exit 2
fi
interfaces=( $(ip -o -f link link | awk '{print $2}') )
case "${interfaces[@]}" in *"$1"*) found=1 ;; esac
if [ -z $found ]
then
        echo "That interface was not found."
        exit 2
fi
ip=$(ip -o -f inet addr show $1 | awk '{print $4}' | awk -F"/" '{print $1}')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
docker build -t "coach/boot" .
docker kill coach_boot_$1
docker rm coach_boot_$1
docker run -d \
        --name coach_boot_$1 \
	--net=host \
        coach/boot \
	--interface=$1 \
        --dhcp-range=$ip,proxy \
        --pxe-service=tag:iPXE,X86PC,"Booting Path...","$2" \
	--pxe-service=tag:iPXE,BC_EFI,"Booting Path...","$2" \
	--pxe-service=tag:iPXE,X86-64_EFI,"Booting Path...","$2"
# docker logs coach_boot -f
