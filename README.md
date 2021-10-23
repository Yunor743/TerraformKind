## REMINDER:

Following instructions assumes that you are already familiar with
Terraform & Docker and that the tools are installed on your machine.

## USAGE:

### Start the infrastructure with:
```sh
terraform apply
```

### On master init control-plane with:
```sh
kubeadm init --ignore-preflight-errors=all
```

### If you lose the previous token you can create another with:
```sh
kubeadm token create --print-join-command
```

### Join them to the cluster:
> Previous steps gives you the command to enter on each worker node.

```sh
kubeadm --ignore-preflight-errors=all join <IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<CA-HASH>
```

### Copy the configuration from the master node:
`/etc/kubernetes/admin.conf`
### To your personal computer:
`$HOME/.kube/config`

> make sure your user has the correct acl rights to access the file

### Then on your personal computer enter:
```sh
kubectl get node
```

## You have a cluster composed of one master and two workers !

<br>

> Once you have your cluster you can start using kubernetes, here is a good introduction video:
https://www.youtube.com/watch?v=7bA0gTroJjw

<br>

---

## Sources:
https://phoenixnap.com/kb/how-to-install-kubernetes-on-a-bare-metal-server