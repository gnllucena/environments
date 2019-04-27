#!/bin/bash

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS RUNNING."

  exit 0
fi

echo "===== KUBERNETES : STARTING"
minikube start