# !/bin/bash

HELM_CHART_DOCKERREGISTRY_SERVICECLUSTERIP="10.103.40.129"

# TODO: erificar se existe algum deployment em qualquer status
if [ "$(helm status docker-registry)" ]; then
  echo "===== DOCKER REGISTRY IS RUNNING"

  exit 0
fi

echo "===== DOCKER REGISTRY : INSTALLING" # https://hub.kubeapps.com/charts/stable/docker-registry
helm install stable/docker-registry \
     --name docker-registry \
     --namespace docker-registry \
     --version 1.8.0 \
     --values ./../configurations/chart/values.yaml \
     --set persistence.size=2Gi,service.clusterIP=$HELM_CHART_DOCKERREGISTRY_SERVICECLUSTERIP