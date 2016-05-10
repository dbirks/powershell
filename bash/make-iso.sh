#!/bin/bash

cd /home/$USER/customiso/arch/x86_64/
rm airootfs.sfs
sudo mksquashfs squashfs-root airootfs.sfs
md5sum airootfs.sfs > airootfs.md5
cd
sudo genisoimage -l -r -J -V "ARCH_201605" -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o ~/arch-custom.iso ~/customiso
sudo isohybrid arch-custom.iso

if [ "$1" == "usb" ]; then
    sudo dd if=~/arch-custom.iso of=/dev/sdc bs=32M status=progress
    sync
fi

