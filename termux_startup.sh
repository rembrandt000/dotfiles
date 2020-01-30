#!/bin/sh
apt update
apt upgrade
termux-setup-storage
ln -s ./storage/downloads/vimrc.txt ~/.vimrc
ln -s ./storage/downloads/vimfiles
apt install -y git curl vim openssh w3m
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
cp ~/.ssh/id_rsa ~./storage/downloads
