#!/bin/sh
# パッケージの更新
apt update
apt upgrade
# ストレージアクセス設定とシンボリックリンク
termux-setup-storage
ln -s ./storage/downloads/vimrc.txt ~/.vimrc
ln -s ./storage/downloads/vimfiles
# アプリインストール
apt install -y git curl vim openssh w3m
# SSHの設定をするためRSA方式で秘密鍵と公開鍵を作る
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
# 公開鍵をDownloadsディレクトリにコピー
cp ~/.ssh/id_rsa ~./storage/downloads
