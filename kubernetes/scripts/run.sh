#!/bin/bash

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== MINIKUBE IS RUNNING."

  exit 0
fi

echo "===== MINIKUBE : STARTING"
minikube start