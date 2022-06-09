#!/bin/bash

yum install -y net-tools

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -s -

kubectl apply -f /config/hello-kubernetes-first.yaml
kubectl apply -f /config/hello-kubernetes-second.yaml
kubectl apply -f /config/hello-kubernetes-third.yaml

kubectl apply -f /config/hello-kubernetes-ingress.yaml