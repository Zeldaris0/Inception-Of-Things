#!/bin/bash

yum install -y net-tools
systemctl disable firewalld --now
curl -sfL https://get.k3s.io | sh -s - --flannel-iface=eth1 --write-kubeconfig-mode 644
cat /var/lib/rancher/k3s/server/node-token  > /config/TOKEN_FILE