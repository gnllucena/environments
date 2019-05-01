#!/bin/bash

if [ "$(helm ls --all app-gocd)" ]; then
  echo "===== GOCD IS INSTALLED"

  exit 0
fi

echo "===== GOCD : INSTALLING"
helm install --name app-gocd --namespace gocd stable/gocd --version 1.9.0