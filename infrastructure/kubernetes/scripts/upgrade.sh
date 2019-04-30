#!/bin/bash

if [ ! "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS NOT RUNNING"

  exit 0
fi

echo "===== HELM : DOWNLOADING HELM"
curl -L https://git.io/get_helm.sh | bash

echo "===== HELM : INSTALLING"
helm init --history-max 200

echo "===== HELM : ADDING DEFAULT REPOSITORIES"
helm repo add stable https://kubernetes-charts.storage.googleapis.com