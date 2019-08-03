#Disable GUI
#systemctl disable lightdm

#Disable swap
#vim /etc/default/armbian-zram-config

#Installing NO-IP
cd /usr/local/src
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
cd no-ip-2.*
make
make install
/usr/local/bin/noip2 -C
noip2

#---- Kubernetes (kubeadm) on Roc3328 ----
apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 0EBFCD88 
echo "deb [arch=arm64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce
gpasswd -a ubuntu docker

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl


hostnamectl set-hostname privatecloud.example.com
echo "192.168.1.110  privatecloud.example.com privatecloud" >> /etc/hosts
apt upgrade -y
reboot

# as ubuntu user
sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo sysctl net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" | sudo tee -a /etc/sysctl.conf

kubectl completion bash > kubectl.bash
kubeadm completion bash > kubeadm.bash

Network Plugin
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

ubuntu@privatecloud:~$ kubectl get nodes
NAME           STATUS   ROLES    AGE   VERSION
privatecloud   Ready    <none>   10m   v1.15.0

ubuntu@privatecloud:~$ kubectl get pod --all-namespaces
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       nginx-server-75659bf856-jlcdf          1/1     Running   0          4m37s
kube-system   coredns-5c98db65d4-hrdcm               1/1     Running   0          10m
kube-system   coredns-5c98db65d4-r5l79               1/1     Running   0          10m
kube-system   etcd-privatecloud                      1/1     Running   0          9m29s
kube-system   kube-apiserver-privatecloud            1/1     Running   0          9m46s
kube-system   kube-controller-manager-privatecloud   1/1     Running   0          9m42s
kube-system   kube-proxy-qmhs5                       1/1     Running   0          10m
kube-system   kube-scheduler-privatecloud            1/1     Running   0          9m40s
kube-system   weave-net-c2w4c                        2/2     Running   0          7m25s

Master with pods

kubectl taint nodes --all node-role.kubernetes.io/master-
By default, your cluster will not schedule pods on the master for security reasons. If you want to be able to schedule pods on the master, e.g. for a single-machine Kubernetes cluster for development. 
