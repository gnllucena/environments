#!/bin/bash
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

# if [ "$(helm ls --all app-dashboard)" ]; then
#   echo "===== DASHBOARD IS INSTALLED"

#   exit 0
# fi

echo "===== KUBERNETES DASHBOARD : INSTALLING"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

echo "===== KUBERNETES DASHBOARD : INSTALLING DEPENDENCIES"
kubectl apply -f ./../configurations/dependencies.yaml

echo "===== KUBERNETES DASHBOARD : CREATING ADMIN USER"
kubectl apply -f ./../configurations/user.yaml

echo "===== KUBERNETES DASHBOARD : ADMIN USER TOKEN"
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')