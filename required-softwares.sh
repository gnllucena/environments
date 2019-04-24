minikube

if [ "$(kubectl cluster-info dump)" ]; then
  echo "===== KUBECTL ALREADY CONFIGURED"

  exit 1
fi