#!/bin/bash

# LANG=en_us.UTF-8 ssh root@124.243.137.5


# scp /home/user/Dowluads/cluster-admin.json root@124.243.137.5:/root




HOME_DIR="$HOME"
KUBECTL_URL="https://sandbox-expriment-files.obs.cn-north-1.myhuaweicloud.com:443/20221021/kubernetes-client-linux-amd64.tar.gz"


cd ~


wget $KUBECTL_URL
tar -zxvf kubernetes-client-linux-amd64.tar.gz


cp /root/kubernetes/client/bin/kubectl /home/
cp kube-root-ca.crt.json /home/

 
chmod +x /home/kubectl
mv /home/kubectl /usr/local/bin

# Kubernetes konfigürasyon dizinini oluştur ve yapılandırmayı kopyala
mkdir -p $HOME/.kube
cp /home/kube-root-ca.crt.json $HOME/.kube/config

# İçsel bağlamı seç
kubectl config use-context internal






[root@ecs-k8s home]# kubectl  get nodes
error: error loading config file "/root/.kube/config": no kind "ClusterRole" is registered for version "rbac.authorization.k8s.io/v1" in scheme "k8s.io/client-go/tools/clientcmd/api/latest/latest.go:50"