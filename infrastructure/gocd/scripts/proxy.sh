# !/bin/bash

if [ ! "$(helm status gocd)" ]; then
  echo "===== GOCD IS NOT INSTALLED"

  exit 0
fi

echo "===== GOCD : PROXYNG"
kubectl port-forward --namespace gocd $(kubectl get pods --namespace gocd --template='{{(index (index .items 0).metadata.name)}}{{"\n"}}') 8153:8153