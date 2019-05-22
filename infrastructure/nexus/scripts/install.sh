# !/bin/bash

# TODO: erificar se existe algum deployment em qualquer status
if [ "$(helm status nexus)" ]; then
  echo "===== NEXUS IS RUNNING"

  exit 0
fi


# https://stackoverflow.com/questions/42766349/run-nexus-3-with-docker-in-a-kubernetes-cluster

echo "===== NEXUS : INSTALLING" # https://github.com/helm/charts/tree/master/stable/sonatype-nexus
helm install stable/sonatype-nexus \
     --name nexus \
     --namespace nexus \
     --version 1.18.1 \
     --values ./../configurations/chart/values.yaml \
     --set nexusProxy.env.nexusDockerHost=nexus.localhost,nexusProxy.env.nexusHttpHost=nexus.localhost,ingress.enabled=true