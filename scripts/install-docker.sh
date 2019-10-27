#!/bin/bash

echo "Installing Docker-CE"
yum install -y -q yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y -q docker-ce

echo "Enabling docker service"
systemctl enable docker
systemctl start docker

echo "Add vagrant to docker group"
usermod -aG docker vagrant
