#!/bin/bash

sudo yum install net-tools
yum provides /usr/sbin/semanage
yum install policycoreutils-python

yum install -y kubectl
curl -sfL https://get.k3s.io | sh -
mkdir /root/.kube
cp /etc/rancher/k3s/k3s.yaml /root/.kube/config