# !/bin/bash

# TODO: verificar se o deployment do gocd-server tem um pod em status running
if [ ! "$(helm status gocd)" ]; then
  echo "===== GOCD IS NOT RUNNING"

  exit 0
fi

echo "===== GOCD : PROXYNG"
# TODO: Acertar o index do pod
kubectl port-forward --namespace gocd $(kubectl get pods --namespace gocd --template='{{(index (index .items 2).metadata.name)}}{{"\n"}}') 8153:8153