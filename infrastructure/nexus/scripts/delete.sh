# !/bin/bash

# TODO: verificar se o deployment do gocd-server tem um pod em status running
if [ ! "$(helm status nexus)" ]; then
  echo "===== NEXUS IS NOT RUNNING"

  exit 0
fi

echo "===== NEXUS : DELETING"
helm del --purge nexus