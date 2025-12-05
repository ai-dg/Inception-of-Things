#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "--------------------------------"
echo "----- Installing server VM -----"
echo "--------------------------------"

echo "Installing debian dependencies"
apt-get update
apt-get install curl -y

echo "Setting IP server and worker into hosts"
echo "${SERVER_IP} dagudeloS" >> /etc/hosts
echo "${WORKER_IP} dagudeloSW" >> /etc/hosts

echo "Installing K3s server with node-ip=${SERVER_IP}..."
mkdir -p /vagrant/confs
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=${SERVER_IP} --bind-address=${SERVER_IP}" sh - 

echo "Waiting for K3s server to start..."
while ! systemctl is-active --quiet k3s; do
    echo "K3s server is starting..."
    sleep 3
done


echo "Getting k3s token from node-token file"
TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

echo "Saving k3s token into /vagrant/confs/k3s.env"
cat <<EOF >/vagrant/confs/k3s.env
K3S_TOKEN=$TOKEN
EOF

mkdir -p /home/vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 600 /home/vagrant/.kube/config

echo 'export KUBECONFIG=/home/vagrant/.kube/config' >> /home/vagrant/.bashrc
echo "alias k='kubectl'" >> /home/vagrant/.bashrc

echo "K3s token saved to /vagrant/confs/k3s.env"
echo "K3s server is ready!"
echo "Server IP: ${SERVER_IP}"