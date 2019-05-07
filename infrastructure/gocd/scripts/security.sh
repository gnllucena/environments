# !/bin/bash

# git@ssh.dev.azure.com:v3/Monqei/Nuget/monqei-services
#
# TODO: a url do fingerprint deveria ser uma variavel de ambiente global
#

CONTAINER_GOCD_NAME="gocd-server-container"
FOLDER_SSHKEYS="./../../../tools/keys"
FOLDER_SSHKEYNAME="id_rsa"
FOLDER_KNOWNHOSTSNAME="known_hosts"
FOLDER_GOCD_SSHKEYS="/home/go/.ssh"

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
    
    ssh-keyscan ssh.dev.azure.com >> $FOLDER_KNOWNHOSTSNAME
fi

echo "===== GOCD : DELETING GOCD SECRETS"
kubectl delete secret --namespace gocd gocd-server-ssh
kubectl delete secret --namespace gocd gocd-agent-ssh
kubectl delete secret --namespace gocd docker-registry

echo "===== GOCD : CONFIGURING SSH KEYS FOR GOCD SERVER"
kubectl create secret --namespace gocd generic gocd-server-ssh \
    --from-file=id_rsa=$FOLDER_SSHKEYNAME \
    --from-file=id_rsa.pub=$FOLDER_SSHKEYNAME.pub \
    --from-file=known_hosts=$FOLDER_KNOWNHOSTSNAME

echo "===== GOCD : CONFIGURING SSH KEYS FOR GOCD AGENT"
kubectl create secret --namespace gocd generic gocd-agent-ssh \
    --from-file=id_rsa=$FOLDER_SSHKEYNAME \
    --from-file=id_rsa.pub=$FOLDER_SSHKEYNAME.pub \
    --from-file=known_hosts=$FOLDER_KNOWNHOSTSNAME

echo "===== GOCD : CONFIGURING PRIVATE DOCKER REGISTRY SECRETS"
kubectl create secret --namespace gocd docker-registry \
	docker-registry \
	--namespace gocd \
	--docker-server=localhost:5000 \
	--docker-username=user \
	--docker-password=password \
	--docker-email=registry@monqei.com