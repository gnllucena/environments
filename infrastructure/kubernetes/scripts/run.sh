#!/bin/bash

# https://iamchuka.com/kubernetes-on-digitalocean-coreos-for-65-part-i/
# https://medium.com/@doug.hellinger/how-to-expose-kubernetes-dashboard-through-nginx-ingress-controller-with-custom-ssl-certificate-c25167887963

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING"

  exit 0
fi

echo "===== KUBERNETES : STARTING"
minikube start --bootstrapper kubeadm --memory 6144

echo "===== KUBERNETES : ENABLING INGRESS"
minikube addons enable ingress