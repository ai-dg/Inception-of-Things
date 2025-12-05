#!/bin/bash


export DEBIAN_FRONTEND=noninteractive

echo "Deploying 3 web applications with Ingress..."
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

echo "Waiting for cluster to be ready..."
until kubectl get nodes >/dev/null 2>&1; do
    echo "API server not reachable yet, waiting..."
    sleep 5
done

while ! kubectl get nodes | grep -q " Ready"; do
    echo "Cluster not ready, waiting..."
    sleep 5
done

kubectl create configmap app-shared-assets \
  --from-file=index.php=/vagrant/app/index.php \
  --from-file=main.css=/vagrant/app/css/main.css \
  --from-file=Kubernetes.svg=/vagrant/app/images/Kubernetes.svg \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f /vagrant/confs/app1.yaml
kubectl apply -f /vagrant/confs/app2.yaml
kubectl apply -f /vagrant/confs/app3.yaml
kubectl apply -f /vagrant/confs/nginx-like.yaml

echo "Waiting for deployments to become available..."
kubectl rollout status deployment/app1 --timeout=180s
kubectl rollout status deployment/app2 --timeout=180s
kubectl rollout status deployment/app3 --timeout=180s

echo "Applications deployed successfully!"
echo "Access applications using:"
echo "  curl -H 'Host: app1.com' http://192.168.56.110"
echo "  curl -H 'Host: app2.com' http://192.168.56.110"
echo "  curl http://192.168.56.110 (default app3)"

kubectl get pods
kubectl get services
kubectl get ingress

