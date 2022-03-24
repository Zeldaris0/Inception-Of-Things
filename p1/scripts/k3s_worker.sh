#!/bin/bash

sudo yum install net-tools
yum provides /usr/sbin/semanage
yum install policycoreutils-python

yum install -y kubectl
curl -sfL https://get.k3s.io | K3S_URL=https://servername:6443 K3S_TOKEN=nodetoken sh -