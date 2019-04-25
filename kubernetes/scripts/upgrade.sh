#!/bin/bash

FOLDER_SSHKEYS="./../../tools/keys"
FOLDER_SSHKEYNAME="id_rsa"
FOLDER_KNOWNHOSTSNAME="known_hosts"
FOLDER_GOCD_SSHKEYS="/home/go/.ssh"
FOLDER_KUBERNETES_NAMESPACE_SSH="../configurations/namespaces"
FOLDER_KUBERNETES_NAMESPACE_SSHNAME="ssh.yaml"
FOLDER_KUBERNETES_SERVICEACCOUNT_API="../configurations/accounts"
FOLDER_KUBERNETES_SERVICEACCOUNT_APINAME="api.yaml"
SERVICEACCOUNT_NAME="api-service-account"

{
    echo "===== MINIKUBE : API SERVICE ACCOUNT"
    kubectl get serviceAccounts/$SERVICEACCOUNT_NAME
} || {
    echo "===== MINIKUBE : CREATING API SERVICE ACCOUNT"
    kubectl create serviceaccount $SERVICEACCOUNT_NAME
}

{
    echo "===== MINIKUBE : CLUSTER ROLE API_ACCESS"
    kubectl get clusterroles api-access 
} || {
    echo "===== MINIKUBE : CREATING CLUSTER ROLE API_ACCESS"
    kubectl create -f $FOLDER_KUBERNETES_SERVICEACCOUNT_API/$FOLDER_KUBERNETES_SERVICEACCOUNT_APINAME
}

echo "===== MINIKUBE : API SERVICE ACCOUNT BEARER"
kubectl get secrets $(kubectl get serviceaccount $SERVICEACCOUNT_NAME -o json | jq -Mr '.secrets[].name') -o json | jq -Mr '.data.token' | base64 -D