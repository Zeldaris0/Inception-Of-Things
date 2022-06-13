#! /bin/bash

if [ -z $1 ]; then
        echo "Please enter a static ip addr to use during the setup"
        exit 0
fi

ip addr add $1/16 dev enp0s3

# install docker
echo "installing docker"

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
apt-get install -y docker-ce


# install k3d
echo "installing k3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#install kubectl
echo "installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#create k8s cluster
k3d cluster create --api-port $1:6443 -p "80:80@loadbalancer" nhamid

#running the playground application
kubectl create namespace dev
kubectl apply -f confs/playground.yaml -n dev
kubectl apply -f confs/ingress.yaml -n dev



# argocd
# https://tanzu.vmware.com/developer/guides/argocd-gs/
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f confs/argocd.yaml

#check the status of pods
# sudo kubectl get pods -n argocd

#port forwarding for argocd
# sudo kubectl get all -n argocd # to get the service name for tje argocd http server
# sudo kubectl -n argocd port-forward svc/argocd-server 8080:443 --address="0.0.0.0"

#get secrets
# sudo kubectl -n argocd get secrets

# sudo kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
# echo password | base64 decode
# or
# echo $(sudo kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | sed -n 3p | cut -d ":" -f2 | tr -d " ") | base64 -d