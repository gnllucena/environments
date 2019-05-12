# !/bin/bash

# TODO: verificar se o deployment do gocd-server tem um pod em status running
if [ ! "$(helm status docker-registry)" ]; then
  echo "===== DOCKER REGISTRY IS NOT RUNNING"

  exit 0
fi

echo "===== DOCKER REGISTRY : DELETING"
helm del --purge docker-registry