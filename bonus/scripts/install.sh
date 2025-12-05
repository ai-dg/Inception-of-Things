#!/bin/bash


if command -v docker &> /dev/null; then
	echo "Docker already installed..."
else
	echo "Installing Docker..."
fi

if command -v curl &> /dev/null; then
	echo "curl already installed..."
else
	echo "Installing curl"
	sudo apt-get install curl
fi

if command -v k3d &> /dev/null; then
	echo "k3d already installed..."
else
	echo "Installing k3d"
	curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi


if command -v kubectl &> /dev/null; then
	echo "kubectl already installed..."
else
	echo "Installing kubectl..."
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	rm kubectl
	mkdir -p ~/.kube
	echo "kubectl installed."
fi


if command -v helm &> /dev/null; then
	echo "helm already installed...."
else
	echo "Installing helm..."
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
	helm version
fi
