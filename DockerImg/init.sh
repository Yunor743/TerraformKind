#!/bin/sh

# install dependencies
apt-get update &&
apt-get install -y init systemd apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common &&
apt-get clean &&

# === Install docker:
# authorize docker key in gpg
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&

# add docker repo to apt
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&

apt-get update &&
apt-get install -y docker-ce docker-ce-cli containerd.io &&
# service docker start &&

# docker installed & running !!

# === Install kubernetes:

# adding kubernetes gpg key:
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add &&

# adding kubernetes repo:
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" &&

apt-get update &&
apt-get install -y kubelet kubeadm kubectl &&
apt-mark hold kubelet kubeadm kubectl &&
echo "init done"

# kubernetes installed !!
