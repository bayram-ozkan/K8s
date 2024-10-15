#!/bin/bash
# pv-pvc uygulama için 
# PersistentVolumeClaims (PVC)
# PersistentVolume (PV)


docker volume create  nfsvol

docker network create \
  --driver=bridge \
  --subnet=10.255.255.0/24 \
  --ip-range=10.255.255.0/24 \
  --gateway=10.255.255.10 \
  nsfnet


docker run -dit --privileged --restart unless-stopped -e SHARED_DIRECTORY=/data  -v nfsvol:/data --network nsfnet  -p 2049:2049 --name nfssrv ozgurozturknet/nfs:latest


# kubectl apply -f  pod-volume-persistens.yml 



