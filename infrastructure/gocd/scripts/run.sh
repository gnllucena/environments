#!/bin/bash

if [ "$(helm ls --all app-gocd)" ]; then
  echo "===== GOCD IS INSTALLED"

  exit 0
fi

echo "===== GOCD : INSTALLING"
helm install --name gocd --namespace gocd stable/gocd --version 1.9.0

# https://www.vand.io/chart/stable/gocd/ ssh