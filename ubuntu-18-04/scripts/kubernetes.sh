#!/bin/bash

#### REQUIREMENT

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
	policykit-1 \
    software-properties-common

#### DOCKER
sudo apt-get -y remove docker docker-engine docker.io containerd runc

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update

sudo apt-get -y install docker-ce=5:19.03.5~3-0~ubuntu-bionic docker-ce-cli=5:19.03.5~3-0~ubuntu-bionic containerd.io

sudo apt-mark hold docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

sudo systemctl enable docker

#### KUBERNETES

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo apt-get install -y kubelet=1.17.2-00 kubeadm=1.17.2-00 kubectl=1.17.2-00

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl restart kubelet
