# !/bin/bash

# TODO: verificar se o deployment do gocd-server tem um pod em status running
if [ ! "$(helm status nexus)" ]; then
  echo "===== GOCD IS NOT RUNNING"

  exit 0
fi

echo "===== NEXUS : PROXYNG"
kubectl port-forward --namespace nexus $(kubectl get pods --namespace nexus --template='{{(index (index .items 0).metadata.name)}}{{"\n"}}') 8080:8080