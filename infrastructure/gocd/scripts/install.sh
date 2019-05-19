# !/bin/bash

# TODO: erificar se existe algum deployment em qualquer status
if [ "$(helm status gocd)" ]; then
  echo "===== GOCD IS RUNNING"

  exit 0
fi

echo "===== GOCD : INSTALLING" # https://hub.kubeapps.com/charts/stable/gocd
helm install stable/gocd \
     --name gocd \
     --namespace gocd \
     --version 1.9.0 \
     --values ./../configurations/chart/values.yaml \
     --set agent.security.ssh.enabled=true,server.security.ssh.enabled=true,agent.replicaCount=1