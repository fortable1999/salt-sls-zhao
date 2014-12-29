#!/bin/bash
cp -r /usr/share/easy-rsa /etc/openvpn/.
cd /etc/openvpn/easy-rsa
source vars
./clean-all
./build-ca

./build-key-server server
./build-key-server client
./build-dh

rm -rf /etc/openvpn/keys*
cp -rf keys /etc/openvpn/.
