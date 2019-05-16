# !/bin/bash

# TODO: verificar se o deployment do docker-registry está rodando
# if [ ! "$(helm status docker-registry)" ]; then
#   echo "===== DOCKER REGISTRY IS NOT RUNNING"

#   exit 0
# fi

echo "===== DOCKER REGISTRY : CONFIGURING INSECURE DOCKER PUSH FOR LOCALHOST DEPLOY"
echo "{ \"insecure-registries\" : [ \"10.103.40.129:5000\" ]}" >> /etc/docker/daemon.json