#!/usr/bin/env bash

sudo apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils linux-headers-$(uname -r)

wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
sudo sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"
sudo apt-add-repository universe
sudo apt-get -y update


echo "127.0.0.1 jitsi.frenchex.local" | sudo tee -a /etc/hosts

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/jitsi.frenchex.local.key -out /etc/ssl/jitsi.frenchex.local.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=Global Security/OU=IT Department/CN=jitsi.frenchex.local"

sudo systemctl daemon-reload

sudo apt-get -y install jitsi-meet
sudo systemctl daemon-reload
