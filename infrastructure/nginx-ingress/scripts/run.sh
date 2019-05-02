#!/bin/bash

if [ ! "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS NOT RUNNING"

  exit 0
fi

echo "===== NGINX INGRESS : INSTALLING"
helm install --name nginx-ingress stable/nginx-ingress --version 1.6.0