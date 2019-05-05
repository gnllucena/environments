# !/bin/bash

# verificar se o kubernetes ta up
# if [ ! "$(helm status gocd)" ]; then
#   echo "===== GOCD IS NOT RUNNING"

#   exit 0
# fi

echo "===== GOCD : SSH KEYS PATH"
cd ./../../../tools/keys
pwd

echo "===== GOCD : CONFIGURING SSH KEYS"
kubectl create --namespace gocd secret generic gocd-agent-ssh \
    --from-file=id_rsa=id_rsa \
    --from-file=id_rsa.pub=id_rsa.pub \
    --from-file=known_hosts=known_hosts