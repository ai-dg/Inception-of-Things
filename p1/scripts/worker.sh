#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "--------------------------------"
echo "----- Installing worker VM -----"
echo "--------------------------------"

echo "Installing debian dependencies"
apt-get update
apt-get install curl -y

echo "Setting IP server and worker into hosts"
echo "${SERVER_IP} dagudeloS" >> /etc/hosts
echo "${WORKER_IP} dagudeloSW" >> /etc/hosts

echo "Installing K3s agent..."
echo "Waiting for server token..."
while [ ! -f /vagrant/confs/k3s.env ]; do
    echo "Token file not found, waiting for server..."
    sleep 5
done

echo "Getting variables from k3s.env file"
source /vagrant/confs/k3s.env

K3S_URL="https://${SERVER_IP}:6443"
echo "Token found: ${K3S_TOKEN:0:20}..."
echo "Server URL: $K3S_URL"

curl -sfL https://get.k3s.io | K3S_URL=$K3S_URL K3S_TOKEN=$K3S_TOKEN INSTALL_K3S_EXEC="agent --node-ip=${WORKER_IP} --bind-address=${WORKER_IP}" sh -s -

echo "Waiting for K3s agent to start..."
while ! systemctl is-active --quiet k3s-agent; do
    echo "K3s agent is starting..."
    sleep 3
done

echo "K3s agent is ready"