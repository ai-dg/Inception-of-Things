up: install
	@echo "Creating k3d cluster..."
	k3d cluster create --config ./confs/setup.yaml
	@echo "Configuring kubectl to use k3d cluster..."
	@k3d kubeconfig merge iot-p3 --kubeconfig-switch-context
	@echo "Waiting for cluster to be ready..."
	@sleep 3
	@./scripts/setup.sh

install:
	@ ./scripts/install.sh

access:
	@echo "Port-forwarding is running on localhost:8000"
	@KUBECONFIG=$$HOME/.kube/config kubectl port-forward -n argocd svc/argocd-server 8000:80 & 2>/dev/null

clean:
	k3d cluster delete iot-p3

secrets:
	@./scripts/access.sh

status:
	@KUBECONFIG=$$HOME/.kube/config kubectl get pods -n argocd

re: clean up

.PHONY: re fix-docker