#!/bin/bash

if [ "$(helm ls --all gocd-app)" ]; then
  echo "===== GOCD IS INSTALLED"

  exit 0
fi

echo "===== GOCD : DOWNLOADING REPOSITORY"
helm repo add stable https://kubernetes-charts.storage.googleapis.com

echo "===== GOCD : INSTALLING ON KUBERNETES"
helm install --name gocd-app --namespace gocd stable/gocd -f ./../configurations/values.yaml