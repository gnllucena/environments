# !/bin/bash

CONTAINER_GOCD_NAME="gocd-server-container"
FOLDER_SSHKEYS="./../../../tools/keys"
FOLDER_SSHKEYNAME="id_rsa"
FOLDER_KNOWNHOSTSNAME="known_hosts"
FOLDER_GOCD_SSHKEYS="/home/go/.ssh"
FOLDER_GOCD_DOCKER_DAEMONJSON="./../configurations/docker"
FOLDER_GOCD_DOCKER_DAEMONJSONNAME="daemon.json"
SSHKEYS_FINGERPRINT_AZURE="ssh.dev.azure.com"
DOCKERREGISTRY_SERVER="10.103.40.129:5000/v2"
DOCKERREGISTRY_USERNAME="username"
DOCKERREGISTRY_PASSWORD="password"
DOCKERREGISTRY_EMAIL="email"

if ! test -f "$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME"; then
    echo "===== GOCD : CREATING SSH KEYS"

    mkdir -p $FOLDER_SSHKEYS
    
    ssh-keygen -t rsa -b 4096 -f $FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME
fi

echo "===== GOCD : SSH KEYS PATH"
cd $FOLDER_SSHKEYS
pwd

if ! test -f "$FOLDER_KNOWNHOSTSNAME"; then
    echo "===== GOCD : GENERATING SSH FINGERPRINTS"
    
    ssh-keyscan $SSHKEYS_FINGERPRINT_AZURE >> $FOLDER_KNOWNHOSTSNAME
fi

echo "===== GOCD : DELETING GOCD SECRETS"
kubectl delete secret gocd-server-ssh --namespace gocd 
kubectl delete secret gocd-agent-ssh --namespace gocd 
kubectl delete secret docker-registry --namespace gocd 
kubectl delete secret docker-registry-daemon-json --namespace gocd 

echo "===== GOCD : CONFIGURING SSH KEYS FOR GOCD SERVER"
kubectl create secret generic gocd-server-ssh \
    --namespace gocd \
    --from-file=id_rsa=$FOLDER_SSHKEYNAME \
    --from-file=id_rsa.pub=$FOLDER_SSHKEYNAME.pub \
    --from-file=known_hosts=$FOLDER_KNOWNHOSTSNAME

echo "===== GOCD : CONFIGURING SSH KEYS FOR GOCD AGENT"
kubectl create secret generic gocd-agent-ssh \
    --namespace gocd \
    --from-file=id_rsa=$FOLDER_SSHKEYNAME \
    --from-file=id_rsa.pub=$FOLDER_SSHKEYNAME.pub \
    --from-file=known_hosts=$FOLDER_KNOWNHOSTSNAME

echo "===== GOCD : CONFIGURING PRIVATE DOCKER REGISTRY SECRETS"
kubectl create secret docker-registry \
	docker-registry \
    --namespace gocd \
	--docker-server=$DOCKERREGISTRY_SERVER \
	--docker-username=$DOCKERREGISTRY_USERNAME \
	--docker-password=$DOCKERREGISTRY_PASSWORD \
	--docker-email=$DOCKERREGISTRY_EMAIL




# SED no daemon.json para usar o endereço do docker registry no kubernetes
# depois fazer um mount desse secret no pod que builda as coisas
# testar com cat dentro do build do container




# echo "===== GOCD : CONFIGURING PRIVATE DOCKER DAEMON JSON"
# kubectl create secret docker-registry-daemon-json \
#     --namespace gocd \
# 	--from-file=daemon.json=$FOLDER_GOCD_DOCKER_DAEMONJSON/$FOLDER_GOCD_DOCKER_DAEMONJSONNAME \