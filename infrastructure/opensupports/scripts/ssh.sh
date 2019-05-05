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
    
    ssh-keyscan AMZON RDS >> $FOLDER_KNOWNHOSTSNAME
fi

echo "===== GOCD : CONFIGURING SSH KEYS"
kubectl create --namespace gocd secret generic 923847203984567234987gfa08s7fg-27r1#Q$@$ \
    --from-file=id_rsa=id_rsa \
    --from-file=id_rsa.pub=id_rsa.pub \
    --from-file=known_hosts=known_hosts