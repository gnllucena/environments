# !/bin/bash

KUBERNETES_MEMORY="10000"

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING"

  exit 0
fi

echo "===== MINIKUBE : STARTING"
minikube start --bootstrapper kubeadm --memory $KUBERNETES_MEMORY

echo "===== MINIKUBE : ENABLING INGRESS"
minikube addons enable ingress

echo "===== MINIKUBE : DOWNLOADING HELM"
curl -L https://git.io/get_helm.sh | bash

echo "===== MINIKUBE : INSTALLING HELM"
helm init --history-max 200

echo "===== MINIKUBE : ADDING DEFAULT HELM REPOSITORY"
helm repo add stable https://kubernetes-charts.storage.googleapis.com