#!/bin/bash

yum install -y net-tools
systemctl disable firewalld --now

curl -sfL https://get.k3s.io | sh -s - --flannel-iface=eth1 K3S_URL=https://192.168.42.110:6443 K3S_TOKEN_FILE=\"/config/TOKEN_FILE\"