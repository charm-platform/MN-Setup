#!/bin/bash

sudo touch /var/swap.img

sudo chmod 600 /var/swap.img

sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000

mkswap /var/swap.img

sudo swapon /var/swap.img

sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get dist-upgrade -y

sudo apt-get install nano htop git -y

sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common -y

sudo apt-get install libboost-all-dev -y

sudo add-apt-repository ppa:bitcoin/bitcoin -y

sudo apt-get update -y

sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

wget https://github.com/charm-platform/charm/releases/download/v1.0/ubuntu-16.04.tar.gz

chmod -R 755 /root/ubuntu-16.04.tar.gz

tar xvzf /root/ubuntu-16.04.tar.gz

mkdir /root/charm

mkdir /root/.charmcore

cp /root/charm-cli /root/charm

cp /root/charmd /root/charm

chmod -R 755 /root/charm

chmod -R 755 /root/.charmcore

sudo apt-get install -y pwgen

GEN_PASS=`pwgen -1 20 -n`

IP_ADD=`curl ipinfo.io/ip`

echo -e "rpcuser=charmrpc\nrpcpassword=${GEN_PASS}\nserver=1\nlisten=1\nmaxconnections=256\ndaemon=1\nrpcallowip=127.0.0.1\nexternalip=${IP_ADD}" > /root/.charmcore/charm.conf

cd /root/charm

./charmd

sleep 10

masternodekey=$(./charm-cli masternode genkey)

./charm-cli stop

echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.charmcore/charm.conf

./charmd -daemon

cd /root/.charmcore

echo "Masternode private key: $masternodekey"

echo "GOOD LUCK"
