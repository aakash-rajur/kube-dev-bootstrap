#!/bin/bash

echo "Starting kmaster"
kubeadm init --apiserver-advertise-address=$KAPI_SERVER_ADDRESS --pod-network-cidr=192.168.0.0/16
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

echo "Deploying Calico network"
su - vagrant -c "kubectl create -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml"

echo "Generating joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh

