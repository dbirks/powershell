#!/bin/bash

# modified from http://cdavis.us/wiki/index.php/Arch_Linux_Install_Guide

# prep
mkdir temp
cd temp
sudo pacman -S git expac base-devel yajl --noconfirm

# install cower
# New key as of 2018.01.28
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 487EACC08557AD082088DABA1EB2638FF56C0C53
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg -i PKGBUILD --noconfirm

# install pacaur
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg -i PKGBUILD --noconfirm

# cleanup
cd ..
rm -r temp
