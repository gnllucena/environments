# !/bin/bash

# verificar se o pod do gocd-server está running
if [ ! "$(helm status gocd)" ]; then
  echo "===== GOCD IS NOT RUNNING"

  exit 0
fi

echo "===== GOCD : PROXYNG"
kubectl port-forward --namespace gocd $(kubectl get pods --namespace gocd --template='{{(index (index .items 0).metadata.name)}}{{"\n"}}') 8153:8153