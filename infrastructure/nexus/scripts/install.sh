# !/bin/bash

# TODO: erificar se existe algum deployment em qualquer status
if [ "$(helm status nexus)" ]; then
  echo "===== NEXUS IS RUNNING"

  exit 0
fi

echo "===== NEXUS : INSTALLING" # https://github.com/helm/charts/tree/master/stable/sonatype-nexus
helm install stable/sonatype-nexus \
     --name nexus \
     --namespace nexus \
     --version 1.18.1 \
     --values ./../configurations/chart/values.yaml \
     --set nexusProxy.env.nexusDockerHost=localhost,nexusProxy.env.nexusHttpHost=localhost,nexus.service.clusterIP=10.100.109.66