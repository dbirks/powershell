#!/bin/bash

# Pass this script the archiveteam repo name
# Example:
# ./archiveteam-setup.sh vine-grab

echo "deb http://httpredir.debian.org/debian jessie main contrib non-free
deb-src http://httpredir.debian.org/debian jessie main contrib non-free
deb http://httpredir.debian.org/debian jessie-updates main contrib non-free
deb-src http://httpredir.debian.org/debian jessie-updates main contrib non-free
deb http://security.debian.org/ jessie/updates main contrib non-free
deb-src http://security.debian.org/ jessie/updates main contrib non-free" > /etc/apt/sources.list

apt update
apt upgrade -yq
apt install -yq git tmux vim htop wget libgnutls28-dev lua5.1 liblua5.1-0 liblua5.1-0-dev python-dev python-pip bzip2 zlib1g-dev flex autoconf

pip install --upgrade seesaw

mkdir ~/dev
cd ~/dev

git clone https://github.com/ArchiveTeam/$1.git

cd $1

./get-wget-lua.sh
