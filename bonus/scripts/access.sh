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
echo "To access the GitLab UI, run:"
echo "  kubectl port-forward -n gitlab svc/gitlab-webservice-default 8000:80"
echo ""
echo "Then visit: https://localhost:8000"
echo "Username: root"
echo "Password: $(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 --decode)"