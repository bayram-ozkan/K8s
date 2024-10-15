################################################################################################################################################

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64


# For ARM64
# [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-arm64


chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind

# kind ile cluster kurulurken kaç tane worker ve control plane kurulaçağını ayarlayabilir.

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF


### Config dosyasına göre bir cluster  sistemi oluşturur.
kind create cluster --config kind-config.yaml
