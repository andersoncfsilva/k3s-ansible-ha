#! /bin/bash

scp ubuntu@192.168.3.41:~/.kube/config ~/.kube/config

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo add jetstack https://charts.jetstack.io
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add traefik https://helm.traefik.io/traefik
helm repo update

helm install traefik traefik/traefik \
  --create-namespace \
  --namespace=traefik \
  --values=values.yaml \
  --version 10.24.0
kubectl get svc --all-namespaces -o wide
kubectl get pods --namespace traefik
kubectl apply -f ./inventory/my-cluster/traefik/deployment.yaml

kubectl apply -f ./inventory/my-cluster/nginx/deployment.yaml

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager \
  --create-namespace \
  --namespace cert-manager \
  --values=values.yaml \
  --version v1.9.1
kubectl apply -f ./inventory/my-cluster/cert-manager/deployment.yaml
kubectl get challenges

helm install longhorn longhorn/longhorn \
  --create-namespace \
  --namespace longhorn-system \
  --version 1.3.1

helm install rancher rancher-stable/rancher \
  --create-namespace \
  --namespace cattle-system \
  --set hostname=rancher.local.andersoncfsilva.com \
  --set replicas=3 \
  --set ingress.tls.source=letsencrypt-production \
  --set letsEncrypt.email=andermalk16@gmail.com \
  --set letsEncrypt.ingress.class=traefik-external \
  --version 2.6.6
