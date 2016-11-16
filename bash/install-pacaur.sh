#!/bin/bash

# modified from http://cdavis.us/wiki/index.php/Arch_Linux_Install_Guide

# prep
mkdir temp
cd temp
sudo pacman -S git expac base-devel --noconfirm

# install cower
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg PKGBUILD
sudo pacman -U cower*.tar --noconfirm

# install pacaur
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg PKGBUILD
sudo pacman -U pacaur*.tar --noconfirm

# cleanup
cd ..
rm -r temp
