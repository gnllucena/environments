#!/bin/bash

CONTAINER_GOCD_NAME="gocd-server-container"
FOLDER_SSHKEYS="./../../tools/keys"
FOLDER_SSHKEYNAME="id_rsa"
FOLDER_GOCD_SSHKEYS="/home/go/.ssh"

if [ ! "$(docker ps -a -q -f name=$CONTAINER_GOCD_NAME)" ]; then
  echo "===== GOCD IS NOT RUNNING."

  exit 1
fi

if ! test -f "$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME"; then
    echo "===== GOCD : CREATING SSH KEYS"

    mkdir -p $FOLDER_SSHKEYS
    
    ssh-keygen -t rsa -b 4096 -f $FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME
fi

echo "===== GOCD : CREATING .SSH FOLDER"
docker exec -it --user go $CONTAINER_GOCD_NAME bash -c "mkdir -p /home/go/.ssh"

echo "===== GOCD : COPING SSH KEYS"
docker cp $FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME $CONTAINER_GOCD_NAME:$FOLDER_GOCD_SSHKEYS
docker cp $FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME.pub $CONTAINER_GOCD_NAME:$FOLDER_GOCD_SSHKEYS

echo "===== GOCD : CHANGING SSH KEYS OWNER"
docker exec -it $CONTAINER_GOCD_NAME bash -c "chown go $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME"
docker exec -it $CONTAINER_GOCD_NAME bash -c "chown go $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME.pub"

echo "===== GOCD : CHANGING SSH KEYS GROUP"
docker exec -it $CONTAINER_GOCD_NAME bash -c "chgrp go $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME"
docker exec -it $CONTAINER_GOCD_NAME bash -c "chgrp go $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME.pub"

echo "===== GOCD : CHANGING SSH KEYS ACCESS CONTROL"
docker exec -it --user go $CONTAINER_GOCD_NAME bash -c "chmod 600 $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME"
docker exec -it --user go $CONTAINER_GOCD_NAME bash -c "chmod 600 $FOLDER_GOCD_SSHKEYS/$FOLDER_SSHKEYNAME.pub"

echo "===== GOCD : SSH FINGERPRINTS"
docker exec -it --user go $CONTAINER_GOCD_NAME bash -c "ssh-keyscan ssh.dev.azure.com >> ~/.ssh/known_hosts"

echo "===== GOCD : RESTARTING"
docker restart $CONTAINER_GOCD_NAME