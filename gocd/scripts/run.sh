#!/bin/bash

CONTAINER_GOCD_NAME="gocd-server-container"
CONTAINER_GOCD_VERSION="gocd/gocd-server:v19.2.0"

if [ "$(docker ps -a -q -f name=$CONTAINER_GOCD_NAME)" ]; then
  echo "===== GOCD IS RUNNING."

  exit 0
fi

echo "===== GOCD : CLONING"
docker pull $CONTAINER_GOCD_VERSION

echo "===== GOCD : RUNNING"
docker run --name $CONTAINER_GOCD_NAME -d -p8153:8153 -p8154:8154 $CONTAINER_GOCD_VERSION