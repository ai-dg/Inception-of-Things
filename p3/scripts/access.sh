#!/bin/bash

export KUBECONFIG=~/.kube/config

echo "Argo CD is ready!"
echo ""
echo "To access the Argo CD UI, run:"
echo "  kubectl port-forward -n argocd svc/argocd-server 8000:443"
echo ""
echo "Then visit: https://localhost:8000"
echo "Username: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
