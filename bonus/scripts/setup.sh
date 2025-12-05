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
echo "waiting for argocd..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

kubectl apply -f ./confs/application.yaml

echo "Argo CD is ready!"
echo ""
echo "To access the Argo CD UI, run:"
echo "  kubectl port-forward -n argocd svc/argocd-server 8000:443"
echo ""
echo "Then visit: https://localhost:8000"
echo "Username: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"


echo "creating namespace gitlab..."
kubectl create namespace gitlab || true
echo "Waiting for namespace to be ready..."
sleep 2
echo "Adding GitLab Helm repository..."
helm repo add gitlab https://charts.gitlab.io/ || true
helm repo update
# helm install gitlab gitlab/gitlab \
#   --namespace gitlab \
#   --set global.hosts.domain=gitlab.local \
#   --set global.edition=ce \
#   --set gitlab-runner.install=false \
#   --set prometheus.install=false \
#   --set certmanager-issuer.email=chrisap@live.fr \
#   --set gitlab.webservice.minReplicas=1 \
#   --set gitlab.webservice.maxReplicas=1 \
#   --set gitlab.gitlab-shell.minReplicas=1 \
#   --set gitlab.sidekiq.minReplicas=1 \
#   --set registry.hpa.minReplicas=1 \
#   --set gitlab.kas.minReplicas=1 \
#   --set nginx-ingress.controller.replicaCount=1


helm install gitlab gitlab/gitlab \
  --namespace gitlab \
  --set global.hosts.domain=gitlab.local \
  --set global.edition=ce \
  --set global.ingress.class=traefik \
  --set certmanager-issuer.email=chrisap@live.fr \
  --set global.ingress.configureCertmanager=false \
  --set nginx-ingress.enabled=false \
  --set gitlab-runner.install=false \
  --set prometheus.install=false \
  --set gitlab.webservice.minReplicas=1 \
  --set gitlab.webservice.maxReplicas=1 \
  --set gitlab.gitlab-shell.minReplicas=1 \
  --set gitlab.sidekiq.minReplicas=1 \
  --set registry.hpa.minReplicas=1 \
  --set gitlab.kas.minReplicas=1


kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode ; echo


