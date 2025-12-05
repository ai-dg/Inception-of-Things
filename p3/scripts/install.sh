#!/bin/bash

echo "Installing gnome-terminal..."
sudo apt install -y gnome-terminal

if command -v curl &> /dev/null; then
	echo "curl already installed..."
else
	echo "Installing curl"
	sudo apt-get update -qq
	sudo apt-get install -y curl
fi

if command -v docker &> /dev/null; then
	echo "Docker already installed..."
else
	echo "Installing Docker..."
	sudo apt update
	sudo apt install -y ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo systemctl start docker
	if ! getent group docker > /dev/null 2>&1; then
		sudo groupadd docker
	fi
	sudo usermod -aG docker $USER
	newgrp docker
	sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
	sudo chmod g+rwx "$HOME/.docker" -R
	echo "Docker installed."
fi

if ! sudo systemctl is-active --quiet docker; then
	echo "Starting Docker service..."
	sudo systemctl start docker
	sudo systemctl enable docker
	sleep 3
fi

if ! docker info &> /dev/null; then
	if sudo docker info &> /dev/null; then
		echo "Docker is running but user is not in docker group."
		if ! groups | grep -q docker; then
			echo "Adding user to docker group..."
			sudo usermod -aG docker $USER
			echo "User added to docker group."
		fi
		echo "Fixing Docker socket permissions..."
		sudo chmod 666 /var/run/docker.sock 2>/dev/null || true
		sudo chown root:docker /var/run/docker.sock 2>/dev/null || true
	fi
else
	echo "Docker is running and accessible."
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

