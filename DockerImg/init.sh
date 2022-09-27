#!/bin/sh

# DOCKER_DEBVERSION=5:19.03.0~3-0~debian-buster
K8S_DEBVERSION=1.19.16-00

# install dependencies
apt-get update &&
apt-get install -y init systemd ufw apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common &&
apt-get clean &&

## firewall settings:
# update-alternatives --set iptables /usr/sbin/iptables-legacy &&
# update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy &&
# update-alternatives --set arptables /usr/sbin/arptables-legacy &&
# update-alternatives --set ebtables /usr/sbin/ebtables-legacy &&
# 
# ufw allow 6443/tcp &&
# ufw allow 2379/tcp &&
# ufw allow 2380/tcp &&
# ufw allow 10250/tcp &&
# ufw allow 10251/tcp &&
# ufw allow 10252/tcp &&
# ufw allow 10255/tcp &&
# ufw allow 10251/tcp &&
# ufw allow 10255/tcp &&
# ufw reload &&


# === Install docker:
# authorize docker key in gpg
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&

# add docker repo to apt
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian buster stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&

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
# apt-get install -y kubelet kubeadm kubectl
apt-get install -y kubelet=$K8S_DEBVERSION kubeadm=$K8S_DEBVERSION kubectl=$K8S_DEBVERSION
apt-mark hold kubelet kubeadm kubectl &&

# kubernetes installed !!

# Apply other fix:

echo "net.netfilter.nf_conntrack_max=131072" >> /etc/sysctl.d/99-sysctl.conf &&



# script done
echo "init done"

