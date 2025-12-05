#!/bin/bash

mkdir -p ~/.kube
export KUBECONFIG=~/.kube/config

if [ ! -f ~/.kube/config ]; then
	echo "Error: kubeconfig file not found. Please ensure k3d cluster is created and configured."
	exit 1
fi

echo "creating namespace dev..."
kubectl create namespace dev || true

echo "creating namespace argocd..."
kubectl create namespace argocd || true
echo "deploying argocd..."
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd > /dev/null

echo "installing argocd"
sleep 10

echo "waiting for argocd dependencies..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

kubectl apply -f ./confs/application.yaml
