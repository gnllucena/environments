# !/bin/bash

# TODO: verificar se o deployment do docker-registry está rodando
if [ ! "$(helm status docker-registry)" ]; then
  echo "===== DOCKER REGISTRY IS NOT RUNNING"

  exit 0
fi

echo "===== DOCKER REGISTRY : PROXYNG"
kubectl port-forward --namespace docker-registry $(kubectl get pods --namespace docker-registry -l "app=docker-registry,release=docker-registry" -o jsonpath="{.items[0].metadata.name}") 5000:5000