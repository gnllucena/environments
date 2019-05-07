# !/bin/bash

# TODO: erificar se existe algum deployment em qualquer status
if [ "$(helm status docker-registry)" ]; then
  echo "===== DOCKER REGISTRY IS RUNNING"

  exit 0
fi

echo "===== DOCKER REGISTRY : INSTALLING"
# https://hub.kubeapps.com/charts/stable/docker-registry
helm install --name docker-registry \
             --namespace docker-registry \
             --version 1.8.0 \
             --set persistence.size=2Gi \
             stable/docker-registry