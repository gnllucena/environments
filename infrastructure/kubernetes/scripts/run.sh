# !/bin/bash

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING"

  exit 0
fi

echo "===== KUBERNETES : STARTING"
minikube start --bootstrapper kubeadm --memory 8092

echo "===== KUBERNETES : ENABLING INGRESS"
minikube addons enable ingress