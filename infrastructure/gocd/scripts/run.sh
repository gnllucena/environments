# !/bin/bash

if [ "$(helm status gocd)" ]; then
  echo "===== GOCD IS RUNNING"

  exit 0
fi

echo "===== GOCD : INSTALLING"
helm install --name gocd --namespace gocd stable/gocd --version 1.9.0