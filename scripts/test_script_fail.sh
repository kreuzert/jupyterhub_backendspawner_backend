#!/bin/bash

###
# This scripts simulate a failed spawn. JupyterHub should be able to understand the cancel curl Command and show the user the error message
###

_term() {
  echo "........ Caught SIGTERM signal!"
  kill -TERM "$child" 2>/dev/null
}
trap _term SIGTERM

SERVER="http://127.0.0.1:8002/hub/api/"
echo "curl -X POST -H \"Authorization: token ${JUPYTERHUB_API_TOKEN}\" ${SERVER}${JUPYTERHUB_STATUS_URL}/0"
curl -X POST -H "Authorization: token ${JUPYTERHUB_API_TOKEN}" ${SERVER}${JUPYTERHUB_STATUS_URL}/0
sleep 2
echo "curl -X POST -H \"Authorization: token ${JUPYTERHUB_API_TOKEN}\" ${SERVER}${JUPYTERHUB_STATUS_URL}/1"
curl -X POST -H "Authorization: token ${JUPYTERHUB_API_TOKEN}" ${SERVER}${JUPYTERHUB_STATUS_URL}/1
sleep 2
echo "curl -X POST -H \"Authorization: token ${JUPYTERHUB_API_TOKEN}\" -d'{\"error\": \"Oh No\"}' ${SERVER}${JUPYTERHUB_CANCEL_URL}"
curl -X POST -H "Authorization: token ${JUPYTERHUB_API_TOKEN}" -d'{"error": "Oh No"}' ${SERVER}${JUPYTERHUB_CANCEL_URL}
