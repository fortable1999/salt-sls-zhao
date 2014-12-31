## context table
1. [how to make keys](#how-to-make-keys)

## how to make keys
```
# get easy-rsa
cp -r /usr/share/easy-rsa/ /etc/openvpn/.
cd /etc/openvpn/easy-rsa/2.0

# load environment
source vars

# if want to clear all keys
./clean-all

# build CA key
./build-ca

# build server key pair
./build-key-server server

# build client key pair
./build-key client

# generate Diffie-Hellman key
./build-dh
```
