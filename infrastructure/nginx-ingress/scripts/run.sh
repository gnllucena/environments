#!/bin/bash

if [ ! "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBERNETES IS NOT RUNNING"

  exit 0
fi

echo "===== NGINX INGRESS : INSTALLING"
helm install --name app-nginx-ingress stable/nginx-ingress --version 1.6.0

echo "===== NGINX INGRESS : WAITING DEPLOY"
kubectl --namespace default get services -o wide -w app-nginx-ingress-controller