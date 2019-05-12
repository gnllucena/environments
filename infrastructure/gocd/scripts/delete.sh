# !/bin/bash

# TODO: verificar se o deployment do gocd-server tem um pod em status running
if [ ! "$(helm status gocd)" ]; then
  echo "===== GOCD IS NOT RUNNING"

  exit 0
fi

echo "===== GOCD : DELETING"
helm del --purge gocd