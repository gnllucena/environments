# #!/bin/bash

# FOLDER_SSHKEYS="./../../tools/keys"
# FOLDER_SSHKEYNAME="id_rsa"
# FOLDER_KNOWNHOSTSNAME="known_hosts"
# FOLDER_GOCD_SSHKEYS="/home/go/.ssh"
# FOLDER_KUBERNETES_NAMESPACE_SSH="../configurations/namespaces"
# FOLDER_KUBERNETES_NAMESPACE_SSHNAME="ssh.yaml"


# if [ ! "$(kubectl cluster-info dump)" ]; then
#   echo "===== MINIKUBE IS NOT RUNNING."

#   exit 0
# fi

# if ! test -f "$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME"; then
#     echo "===== MINIKUBE : CREATING SSH KEYS"

#     mkdir -p $FOLDER_SSHKEYS
    
#     ssh-keygen -t rsa -b 4096 -f $FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME
# fi

# echo "===== MINIKUBE : CREATING KNOWN_HOSTS FILE"
# ssh-keyscan localhost > $FOLDER_SSHKEYS/$FOLDER_KNOWNHOSTSNAME

# {
#     echo "===== MINIKUBE : REPLACING SSH SECRET"
#     kubectl create secret generic ssh --namespace default  --from-file=id_rsa=$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME --from-file=id_rsa.pub=$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME.pub --from-file=known_hosts=$FOLDER_SSHKEYS/$FOLDER_KNOWNHOSTSNAME -o yaml --dry-run | kubectl replace -f -
# } || {
#     echo "===== MINIKUBE : CREATING SSH SECRET"
#     kubectl create secret generic ssh --namespace default --from-file=id_rsa=$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME --from-file=id_rsa.pub=$FOLDER_SSHKEYS/$FOLDER_SSHKEYNAME.pub --from-file=known_hosts=$FOLDER_SSHKEYS/$FOLDER_KNOWNHOSTSNAME 
# }
