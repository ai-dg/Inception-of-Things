
build: install
	@echo "Creating k3d cluster..."
	k3d cluster create --config ./confs/setup.yaml
	@echo "Configuring kubectl to use k3d cluster..."
	@k3d kubeconfig merge iot-bonus --kubeconfig-switch-context
	@echo "Waiting for cluster to be ready..."
	@sleep 3
	@./scripts/setup.sh

start:
	k3d cluster start iot-bonus

install:
	@ ./scripts/install.sh

access:
	@echo "Port-forwarding is running on localhost:8000"
	@KUBECONFIG=$$HOME/.kube/config kubectl port-forward -n argocd svc/argocd-server 8000:80 & 2>/dev/null

stop:
	k3d cluster stop iot-bonus


secrets:
	@./scripts/access.sh