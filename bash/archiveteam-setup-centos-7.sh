#!/bin/bash

# Example usage:
# run-pipeline pipeline.py  --concurrent 20 --disable-web-server lain

yum update -y
yum install -y epel-release
yum install -y autoconf automake flex gnutls-devel lua-devel python-pip zlib-devel bzip2 git gcc tmux htop nload
git clone https://github.com/ArchiveTeam/panoramio-grab.git
cd panoramio-grab
pip install --upgrade seesaw
./get-wget-lua.sh
