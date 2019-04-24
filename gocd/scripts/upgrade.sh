#!/bin/bash

CONTAINER_GOCD_NAME="gocd-server-container"
FOLDER_KUBERNETESELASTICAGENT="./../repositories/kubernetes-elastic-agents"
FOLDER_GOCD_PLUGINS="/go-working-dir/plugins/external"
FOLDER_GOCD_CRUISECONFIG="/go-w­orkin­g-dir­/conf­ig"
REPOSITORY_KUBERNETESELASTICAGENT_COMMIT="6d1b428369beceeac5de0052051ef32640530a64"

if [ ! "$(docker ps -a -q -f name=$CONTAINER_GOCD_NAME)" ]; then
  echo "===== GOCD IS NOT RUNNING."

  exit 1
fi

if [ ! -d $FOLDER_KUBERNETESELASTICAGENT ]; then
  echo "===== GOCD : KUBERNETES ELASTIC AGENTS - CLONING "
  git clone https://github.com/gocd/kubernetes-elastic-agents.git $FOLDER_KUBERNETESELASTICAGENT
fi

echo "===== GOCD : KUBERNETES ELASTIC AGENTS - CHECKING VERSIONS"
cd $FOLDER_KUBERNETESELASTICAGENT

git checkout $REPOSITORY_KUBERNETESELASTICAGENT_COMMIT

echo "===== GOCD : KUBERNETES ELASTIC AGENTS - BUILDING"
./gradlew clean assemble

cd ../

echo "===== GOCD : KUBERNETES ELASTIC AGENTS - INSTALLING"
docker cp $FOLDER_KUBERNETESELASTICAGENT/build/libs/kubernetes-elastic-agent-*.jar $CONTAINER_GOCD_NAME:$FOLDER_GOCD_PLUGINS

echo "===== GOCD : RESTARTING"
docker restart $CONTAINER_GOCD_NAME