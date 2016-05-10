#!/bin/bash
#
# Script to largely automate the creation of an .iso file for a custom arch installation.
#
# Usage:
#
# To create a usb-bootable .iso run:
# ./make-iso.sh 
#
# To also write it to a usb drive with one FAT32 partition, pass the script the parameter "usb", followed by the device name:
# ./make-iso.sh usb sdc
 
cd ~/customiso/arch/x86_64/
sudo rm airootfs.sfs
sudo mksquashfs squashfs-root airootfs.sfs
md5sum airootfs.sfs > airootfs.md5
cd
sudo genisoimage -l -r -J -V "ARCH_201605" \
    -b isolinux/isolinux.bin \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -c isolinux/boot.cat \
    -o ~/arch-custom.iso ~/customiso

# make .iso usb-bootable
sudo isohybrid arch-custom.iso

# check for parameters, and write to usb drive if requested
if [ "$1" == "usb" ]; then
    sudo dd if=~/arch-custom.iso of=/dev/$2 bs=32M status=progress
    sync
fi

