## REMINDER:

Following instructions assumes that you are already familiar with
Terraform & Docker and that the tools are installed on your machine.

## USAGE:

### Disable your host system swap:
> Recommended in the kubernetes doc
```sh
sudo swapoff -a
```

### Build the docker image for node
```
cd DockerImg;
docker build -t terraformkind-k8snode .
```

### Initialize the infrastructure
```sh
terraform init
```

### Start the infrastructure with:
```sh
terraform apply
```

### On each terraformkind-k8snode container enter the following command:
```
mkdir -p /run/flannel && cp /root/subnet.env /run/flannel/
```
> If one of your nodes reboot you have to re-enter this command

### On master init control-plane with:
```sh
kubeadm init --ignore-preflight-errors=all --pod-network-cidr=10.244.0.0/16
```

### If you lose the previous token you can create another with:
```sh
kubeadm token create --print-join-command
```

### Join workers to the cluster:
> Previous steps gives you the command to enter on each worker node.

```sh
kubeadm --ignore-preflight-errors=all join <IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<CA-HASH>
```

> Notice the usage of `--ignore-preflight-errors=all` in the previous command


### Copy the configuration from the master node:
`/etc/kubernetes/admin.conf`
### To your personal computer:
`$HOME/.kube/config`

> make sure your user has the correct acl rights to access the file

<br>

### _Then on your personal computer_

### Add pod network add-on:
```sh
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

### finally list connected nodes:
```sh
kubectl get node
```
> you may have to wait a few minutes until your nodes are ready

## You have a cluster composed of one master and two workers !

<br>

> Once you have your cluster you can start using kubernetes, here is a good introduction video:
https://www.youtube.com/watch?v=7bA0gTroJjw

<br>

---

## Sources:

- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
- https://phoenixnap.com/kb/how-to-install-kubernetes-on-a-bare-metal-server
