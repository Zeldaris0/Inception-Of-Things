#!/bin/bash

yum install -y net-tools

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -s -
cat /var/lib/rancher/k3s/server/node-token  > /config/TOKEN_FILE