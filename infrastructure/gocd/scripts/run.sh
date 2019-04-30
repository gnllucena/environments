#!/bin/bash

if [ "$(helm ls --all app-gocd)" ]; then
  echo "===== GOCD IS INSTALLED"

  exit 0
fi

echo "===== GOCD : DOWNLOADING REPOSITORY"
helm repo add stable https://kubernetes-charts.storage.googleapis.com

echo "===== GOCD : INSTALLING ON KUBERNETES"
helm install --name app-gocd --namespace gocd stable/gocd -f ./../configurations/values.yaml --version 1.9.0

# helm del --purge gocd-app 
# helm install stable/kubernetes-dashboard --namespace kube-system 
#kubectl -n kube-system create secret generic kubernetes-dashboard-key-holder