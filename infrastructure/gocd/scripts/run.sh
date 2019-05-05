# !/bin/bash

# verificar se existe algum deployment em qualquer status
if [ "$(helm status gocd)" ]; then
  echo "===== GOCD IS RUNNING"

  exit 0
fi

echo "===== GOCD : INSTALLING"
helm install --name gocd --namespace gocd stable/gocd -f ./../configurations/values.yaml --version 1.9.0