#!/bin/bash

echo "===== KUBERNETES : DOWNLOADING HELM"
curl -L https://git.io/get_helm.sh | bash

echo "===== KUBERNETES : STARTING HELM"
helm init --history-max 200