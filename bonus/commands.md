## Before commands
```bash
export KUBECONFIG=~/.kube/config
```

## Checking pods states
```bash
kubectl get pods -n gitlab
```
`If all is Running and complete, next step`


## Getting hosts from ingress and put them into /etc/hosts
```bash
kubectl get ingress --all-namespaces
``

```bash
172.18.0.2	kas.gitlab.local
172.18.0.2	minio.gitlab.local
172.18.0.2	registry.gitlab.local
172.18.0.2	gitlab.gitlab.local
172.18.0.2  deployed.com
```

## Getting password for Gitlab
```bash
kubectl get secret gitlab-gitlab-initial-root-password -n gitlab \
  -ojsonpath='{.data.password}' | base64 --decode && echo
```

## Creating new repository
Profile -> new blank project -> api, read, write rights

## Creating PAT
Profile -> Settings -> Personnal access token

## Adding PAT into kubectl

```bash
kubectl delete secret gitlab-repo-creds -n argocd
kubectl create secret generic gitlab-repo-creds \
  -n argocd \
  --from-literal=type=git \
  --from-literal=url=http://gitlab-webservice-default.gitlab.svc:8181 \
  --from-literal=username=root \
  --from-literal=password=glpat-AEB4CMlffwqyxMPccUrsSW86MQp1OjEH.01.0w0asehak
```

## Unable SSL checking just for this host
```bash
git config --global http."https://gitlab.gitlab.local/".sslVerify false
```

## Delete argocd old PAT
```bash
kubectl delete secret gitlab-repo-creds -n argocd --ignore-not-found
```

## Adding new PAT
```bash
kubectl create secret generic gitlab-repo-creds \
  -n argocd \
  --from-literal=type=git \
  --from-literal=url=http://gitlab-webservice-default.gitlab.svc:8181/root/calbor-p-iot-bonus.git \
  --from-literal=username=root \
  --from-literal=password=glpat-dvzm1cMahZbGPYshNyHFcm86MQp1OjEH.01.0w1cl8g3s

```

## Adding label in argocd
```bash
kubectl label secret gitlab-repo-creds \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
```

## Restart argocd
```bash
kubectl rollout restart deployment argocd-repo-server -n argocd

```

## Verify creds
```bash
kubectl get secrets -n argocd | grep gitlab

```









```bash
kubectl delete secret gitlab-repo-creds -n argocd


kubectl label secret gitlab-repo-creds \
  -n argocd \
  argocd.argoproj.io/secret-type=repository
  

kubectl rollout restart deployment argocd-repo-server -n argocd
```