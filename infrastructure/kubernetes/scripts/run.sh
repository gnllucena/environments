# !/bin/bash

KUBERNETES_MEMORY="4048"

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING"

  exit 0
fi

echo "===== KUBERNETES : STARTING"
minikube start --bootstrapper kubeadm --memory $KUBERNETES_MEMORY

echo "===== KUBERNETES : ENABLING INGRESS"
minikube addons enable ingress