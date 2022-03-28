#!/bin/bash

yum install -y net-tools
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_URL=https://192.168.42.110:6443 K3S_TOKEN=$(cat /config/TOKEN_FILE) INSTALL_K3S_EXEC="--flannel-iface eth1" sh -s -