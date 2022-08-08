#! /bin/bash

scp ubuntu@192.168.3.41:~/.kube/config ~/.kube/config

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo add jetstack https://charts.jetstack.io
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update


kubectl create namespace cattle-system
kubectl create namespace cert-manager
kubectl create namespace nginx-system


helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace nginx-system \
  --version 4.2.0

kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.7.1
kubectl apply -f letsencrypt.yml

helm install rancher rancher-stable/rancher \
   --namespace cattle-system \
   --set hostname=rancher.local.andersoncfsilva.com \
   --set bootstrapPassword=admin \
   --set replicas=3 \
   --set ingress.tls.source=letsencrypt \
   --set letsEncrypt.email=andermalk16@gmail.com \
   --set letsEncrypt.ingress.class=nginx \
   --version 2.6.4


kubectl -n cattle-system rollout status deploy/rancher
kubectl expose deployment rancher -n cattle-system --type=LoadBalancer --name=rancher-lb --port=443
