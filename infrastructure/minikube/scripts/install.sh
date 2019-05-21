# !/bin/bash

KUBERNETES_MEMORY="4096"

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING"

  exit 0
fi

echo "===== MINIKUBE : STARTING"
minikube start --bootstrapper kubeadm \
               --memory $KUBERNETES_MEMORY \
               --insecure-registry "172.17.0.8:8083"

echo "===== MINIKUBE : ENABLING INGRESS"
minikube addons enable ingress

echo "===== MINIKUBE : DOWNLOADING HELM"
curl -L https://git.io/get_helm.sh | bash

echo "===== MINIKUBE : INSTALLING HELM"
helm init --history-max 200

echo "===== MINIKUBE : ADDING DEFAULT HELM REPOSITORY"
helm repo add stable https://kubernetes-charts.storage.googleapis.com