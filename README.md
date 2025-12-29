# Inception-of-Things (IoT) 🚀
![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s%20%7C%20K3d-326CE5?logo=kubernetes&logoColor=white)
![Vagrant](https://img.shields.io/badge/Vagrant-1868F2?logo=vagrant&logoColor=white)
![ArgoCD](https://img.shields.io/badge/ArgoCD-EF7B4D?logo=argo&logoColor=white)
![GitLab](https://img.shields.io/badge/GitLab-FC6D26?logo=gitlab&logoColor=white)

**A comprehensive introduction to Kubernetes using K3s, K3d, Vagrant, and GitOps practices with ArgoCD**

> Learn Kubernetes fundamentals by setting up clusters, deploying applications, and implementing continuous deployment with ArgoCD and GitLab.

---

## ▌Project Overview

This project is a **System Administration exercise** that provides a hands-on introduction to **Kubernetes** through progressive complexity.\
It covers cluster setup with **K3s** and **K3d**, virtual machine management with **Vagrant**, application deployment, and **GitOps** practices using **ArgoCD**.

The project is divided into **three mandatory parts** and **one bonus part**, each building upon the previous one to deepen your understanding of container orchestration and modern DevOps practices.

📘 **Educational DevOps project**: Build Kubernetes clusters from scratch and implement CI/CD pipelines step-by-step.

---

## ▌Features

✔️ **K3s Cluster Setup**: Multi-node Kubernetes cluster with server and worker nodes\
✔️ **Vagrant Automation**: Automated VM provisioning and configuration\
✔️ **Ingress Configuration**: Host-based routing for multiple applications\
✔️ **K3d Integration**: Lightweight Kubernetes in Docker for development\
✔️ **ArgoCD Deployment**: GitOps-based continuous deployment\
✔️ **Application Replicas**: Horizontal scaling with multiple pod replicas\
✔️ **Automated Scripts**: Installation and setup automation for all components

---

## ▌Bonus Features

- ■ **GitLab Integration**: Self-hosted GitLab instance running in Kubernetes
- ■ **Complete CI/CD Pipeline**: Full GitOps workflow with GitLab and ArgoCD
- ■ **Helm Charts**: GitLab deployment using Helm package manager
- ■ **Custom Application**: PHP-based web application with Kubernetes branding

> ⚠️ Bonus features are only evaluated if the mandatory parts work flawlessly.

---

## ▌Project Structure

```
Inception-of-Things/
├── p1/                          # Part 1: K3s and Vagrant
│   ├── Vagrantfile             # VM configuration (Server + Worker)
│   ├── Makefile                # Automation commands
│   └── scripts/
│       ├── server.sh           # K3s server setup script
│       └── worker.sh           # K3s agent setup script
│
├── p2/                          # Part 2: K3s and three applications
│   ├── Vagrantfile             # Single VM configuration
│   ├── Makefile                # Automation commands
│   ├── app/                    # Application assets
│   │   ├── index.php
│   │   ├── css/
│   │   └── images/
│   ├── confs/                  # Kubernetes manifests
│   │   ├── app1.yaml           # App1 deployment (1 replica)
│   │   ├── app2.yaml           # App2 deployment (3 replicas)
│   │   ├── app3.yaml           # App3 deployment (1 replica)
│   │   └── nginx-like.yaml     # Ingress configuration
│   └── scripts/
│       ├── server.sh           # K3s server setup
│       └── deploy_apps.sh      # Application deployment
│
├── p3/                          # Part 3: K3d and ArgoCD
│   ├── Makefile                # Automation commands
│   ├── confs/
│   │   ├── application.yaml    # ArgoCD Application manifest
│   │   ├── setup.yaml          # Kubernetes resources
│   │   └── app/                # Application Docker image
│   │       ├── Dockerfile
│   │       ├── init.sh
│   │       └── html/
│   └── scripts/
│       ├── install.sh          # Install Docker, K3d, kubectl
│       ├── setup.sh            # Setup cluster and ArgoCD
│       └── access.sh           # Access ArgoCD UI
│
└── bonus/                       # Bonus: GitLab Integration
    ├── Makefile                # Automation commands
    ├── confs/
    │   ├── application.yaml    # ArgoCD app with GitLab repo
    │   ├── setup.yaml          # Kubernetes resources
    │   └── app/                # Application Docker image
    ├── gitlab/
    │   └── deployment.yaml     # GitLab Kubernetes manifests
    └── scripts/
        ├── install.sh          # Install dependencies
        ├── setup.sh            # Setup GitLab + ArgoCD
        └── access.sh           # Access services
```

---

## ▌How It Works

### ■ Part 1: K3s and Vagrant

**Objective**: Set up a 2-node Kubernetes cluster using K3s and Vagrant.

**Architecture**:
- **Server Node** (`dagudeloS`): K3s in controller mode at `192.168.56.110`
- **Worker Node** (`dagudeloSW`): K3s in agent mode at `192.168.56.111`

**Key Concepts**:
- Virtual machine provisioning with Vagrant
- K3s lightweight Kubernetes distribution
- Multi-node cluster configuration
- SSH key-based authentication

### ■ Part 2: K3s and Three Applications

**Objective**: Deploy 3 web applications with host-based routing using Ingress.

**Architecture**:
- Single VM running K3s server
- 3 PHP applications with different replica counts:
  - **app1**: 1 replica, accessible via `app1.com`
  - **app2**: 3 replicas, accessible via `app2.com`
  - **app3**: 1 replica, default route (fallback)

**Key Concepts**:
- Kubernetes Deployments and Services
- Ingress controller for HTTP routing
- ConfigMaps for application assets
- Horizontal pod scaling

### ■ Part 3: K3d and ArgoCD

**Objective**: Implement GitOps continuous deployment with ArgoCD.

**Architecture**:
- K3d cluster (Kubernetes in Docker)
- Two namespaces:
  - `argocd`: ArgoCD installation
  - `dev`: Application deployment
- GitHub repository for GitOps
- Automated synchronization

**Key Concepts**:
- K3d for local development
- GitOps methodology
- ArgoCD for continuous deployment
- Application versioning (v1, v2)
- Declarative configuration

### ■ Bonus: GitLab Integration

**Objective**: Replace GitHub with self-hosted GitLab for complete CI/CD.

**Architecture**:
- GitLab CE running in Kubernetes
- GitLab namespace with Helm deployment
- ArgoCD syncing from local GitLab repository
- Complete on-premise GitOps workflow

**Key Concepts**:
- Helm package manager
- Self-hosted Git repository
- Internal service communication
- Enterprise GitOps practices

---

## ▌Getting Started

### ■ Prerequisites

**For Parts 1 & 2 (Vagrant-based)**:
- Vagrant (latest version)
- VirtualBox or Libvirt provider
- 4GB+ RAM available
- Linux/macOS/Windows host

**For Part 3 & Bonus (K3d-based)**:
- Docker (20.10+)
- kubectl
- K3d
- Helm (for bonus)
- 8GB+ RAM available

### ■ Installation

#### Part 1: K3s and Vagrant

```bash
cd p1

# Start the cluster
make up

# Check cluster status
make status

# SSH into server
make ssh-server

# SSH into worker
make ssh-worker

# Destroy cluster
make down
```

#### Part 2: K3s and Three Applications

```bash
cd p2

# Start VM and deploy apps
make up

# Check deployments
make status

# Test applications
curl -H "Host: app1.com" http://192.168.56.110
curl -H "Host: app2.com" http://192.168.56.110
curl http://192.168.56.110  # Default: app3

# Destroy VM
make down
```

#### Part 3: K3d and ArgoCD

```bash
cd p3

# Install dependencies (Docker, K3d, kubectl)
make install

# Create cluster and setup ArgoCD
make setup

# Access ArgoCD UI
make access

# Clean up
make clean
```

#### Bonus: GitLab Integration

```bash
cd bonus

# Install dependencies
make install

# Setup GitLab and ArgoCD
make setup

# Access services
make access

# Clean up
make clean
```

---

## ▌Usage Instructions

### ■ Part 1: Cluster Management

```bash
# Inside the server VM
vagrant ssh dagudeloS

# Check nodes
kubectl get nodes

# Expected output:
# NAME          STATUS   ROLES                  AGE   VERSION
# dagudelows    Ready    <none>                 5m    v1.28.x
# dagudeloss    Ready    control-plane,master   5m    v1.28.x

# Check pods
kubectl get pods -A
```

### ■ Part 2: Application Testing

```bash
# Test app1 (1 replica)
curl -H "Host: app1.com" http://192.168.56.110

# Test app2 (3 replicas)
curl -H "Host: app2.com" http://192.168.56.110

# Test app3 (default)
curl http://192.168.56.110

# Check ingress
kubectl get ingress

# Check pods
kubectl get pods
# Expected: 1 app1 pod, 3 app2 pods, 1 app3 pod
```

### ■ Part 3: ArgoCD Operations

```bash
# Port forward ArgoCD UI
kubectl port-forward -n argocd svc/argocd-server 8080:443

# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d

# Access UI at: https://localhost:8080
# Username: admin
# Password: <from above command>

# Check application status
kubectl get applications -n argocd

# Check deployed app
kubectl get pods -n dev
```

### ■ Bonus: GitLab + ArgoCD

```bash
# Get GitLab root password
kubectl get secret gitlab-gitlab-initial-root-password \
  -n gitlab -o jsonpath='{.data.password}' | base64 -d

# Port forward GitLab
kubectl port-forward -n gitlab svc/gitlab-webservice-default 8181:8181

# Access GitLab at: http://localhost:8181
# Username: root
# Password: <from above command>

# Create repository and push code
# ArgoCD will automatically sync changes
```

---

## ▌Configuration Details

### ■ Part 1: VM Specifications

| Component | Server (dagudeloS) | Worker (dagudeloSW) |
|-----------|-------------------|---------------------|
| **OS** | Debian Bookworm 64 | Debian Bookworm 64 |
| **IP** | 192.168.56.110 | 192.168.56.111 |
| **RAM** | 1024 MB | 1024 MB |
| **CPU** | 1 core | 1 core |
| **K3s Role** | Server (controller) | Agent (worker) |

### ■ Part 2: Application Configuration

| Application | Replicas | Host | Service Port |
|-------------|----------|------|--------------|
| **app1** | 1 | app1.com | 80 |
| **app2** | 3 | app2.com | 80 |
| **app3** | 1 | * (default) | 80 |

### ■ Part 3: Namespace Structure

| Namespace | Purpose | Components |
|-----------|---------|------------|
| **argocd** | GitOps Controller | ArgoCD server, repo-server, application-controller |
| **dev** | Application Deployment | Custom PHP application (v1/v2) |

### ■ Bonus: GitLab Configuration

| Component | Namespace | Service | Port |
|-----------|-----------|---------|------|
| **GitLab CE** | gitlab | gitlab-webservice-default | 8181 |
| **ArgoCD** | argocd | argocd-server | 443 |
| **Application** | dev | app-service | 80 |

---

## ▌Key Technologies

### Kubernetes Distributions
- **K3s**: Lightweight Kubernetes for production (Parts 1 & 2)
- **K3d**: K3s in Docker for development (Part 3 & Bonus)

### Infrastructure as Code
- **Vagrant**: VM provisioning and management
- **Shell Scripts**: Automated installation and configuration

### Container Orchestration
- **Deployments**: Application lifecycle management
- **Services**: Internal networking and load balancing
- **Ingress**: HTTP routing and external access
- **ConfigMaps**: Configuration management

### GitOps & CI/CD
- **ArgoCD**: Declarative continuous deployment
- **GitLab**: Self-hosted Git repository and CI/CD
- **Helm**: Kubernetes package manager

---

## ▌Troubleshooting

### Common Issues

#### Part 1: Nodes not joining cluster

```bash
# On server, check token
vagrant ssh dagudeloS
cat /var/lib/rancher/k3s/server/node-token

# On worker, verify token in script
vagrant ssh dagudeloSW
cat /vagrant/confs/k3s.env
```

#### Part 2: Ingress not working

```bash
# Check ingress controller
kubectl get pods -n kube-system | grep traefik

# Check ingress rules
kubectl describe ingress apps-ingress

# Test with curl verbose
curl -v -H "Host: app1.com" http://192.168.56.110
```

#### Part 3: ArgoCD not syncing

```bash
# Check ArgoCD application status
kubectl get applications -n argocd

# Check ArgoCD logs
kubectl logs -n argocd deployment/argocd-application-controller

# Force sync
kubectl patch application iot-p3 -n argocd \
  --type merge -p '{"operation":{"initiatedBy":{"username":"admin"},"sync":{}}}'
```

#### Bonus: GitLab not starting

```bash
# Check GitLab pods
kubectl get pods -n gitlab

# Check pod logs
kubectl logs -n gitlab <pod-name>

# Increase resources if needed
# Edit Helm values and upgrade
```

---

## ▌Learning Outcomes

After completing this project, you will understand:

✅ **Kubernetes Architecture**: Control plane, worker nodes, pods, services\
✅ **Container Orchestration**: Deployment strategies, scaling, health checks\
✅ **Networking**: ClusterIP, NodePort, Ingress, DNS\
✅ **GitOps Practices**: Declarative configuration, version control, automated sync\
✅ **Infrastructure as Code**: Vagrant, shell scripting, automation\
✅ **CI/CD Pipelines**: Continuous integration and deployment workflows\
✅ **DevOps Tools**: K3s, K3d, ArgoCD, GitLab, Helm

---

## ▌Project Validation

### Mandatory Requirements

- ✅ **Part 1**: 2-node K3s cluster with Vagrant
  - Server and worker nodes with correct IPs
  - SSH access without password
  - kubectl working on both nodes

- ✅ **Part 2**: 3 applications with Ingress
  - Host-based routing (app1.com, app2.com, default)
  - App2 with 3 replicas
  - All apps accessible via 192.168.56.110

- ✅ **Part 3**: K3d with ArgoCD
  - K3d cluster running
  - ArgoCD installed in argocd namespace
  - Application deployed in dev namespace
  - GitHub repository integration
  - Version switching (v1 ↔ v2)

### Bonus Requirements

- 🎉 **GitLab Integration**: Self-hosted GitLab in Kubernetes
- 🎉 **Complete GitOps**: ArgoCD syncing from local GitLab
- 🎉 **Helm Deployment**: GitLab installed via Helm charts
- 🎉 **Automated Setup**: Scripts for complete installation

---

## ▌Useful Commands

### Vagrant

```bash
vagrant up              # Start VMs
vagrant halt            # Stop VMs
vagrant destroy -f      # Destroy VMs
vagrant ssh <name>      # SSH into VM
vagrant status          # Check VM status
```

### Kubernetes

```bash
kubectl get nodes                    # List nodes
kubectl get pods -A                  # List all pods
kubectl get svc -A                   # List all services
kubectl get ingress                  # List ingress rules
kubectl describe pod <name>          # Pod details
kubectl logs <pod-name>              # Pod logs
kubectl exec -it <pod> -- /bin/sh    # Shell into pod
```

### K3d

```bash
k3d cluster create <name>            # Create cluster
k3d cluster delete <name>            # Delete cluster
k3d cluster list                     # List clusters
k3d node list                        # List nodes
```

### ArgoCD

```bash
kubectl get applications -n argocd   # List applications
kubectl describe app <name> -n argocd # App details
argocd app sync <name>               # Force sync
argocd app get <name>                # App status
```

---

## ▌Resources

### Official Documentation
- [K3s Documentation](https://docs.k3s.io/)
- [K3d Documentation](https://k3d.io/)
- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

### Tutorials
- [K3s Quick Start](https://rancher.com/docs/k3s/latest/en/quick-start/)
- [ArgoCD Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

---

## 📜 License

This project was completed as part of the **42 School** curriculum.\
It is intended for **academic purposes only** and follows the evaluation requirements set by 42.

**Project**: Inception-of-Things (IoT)\
**Version**: 3.1\
**Category**: System Administration

Unauthorized public sharing or direct copying for **grading purposes** is discouraged.\
If you wish to use or study this code, please ensure it complies with **your school's policies**.

---

## 🙏 Acknowledgments

- 42 School for the project subject
- K3s and K3d teams for lightweight Kubernetes
- ArgoCD community for GitOps tooling
- Vagrant and HashiCorp for infrastructure automation
