#!/bin/bash

###
# This script will start a JupyterHub-singleuser command with given arguments
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
echo "curl -X POST -H \"Authorization: token ${JUPYTERHUB_API_TOKEN}\" ${SERVER}${JUPYTERHUB_STATUS_URL}/2"
curl -X POST -H "Authorization: token ${JUPYTERHUB_API_TOKEN}" ${SERVER}${JUPYTERHUB_STATUS_URL}/2
sleep 2
echo "curl -X POST -H \"Authorization: token ${JUPYTERHUB_API_TOKEN}\" ${SERVER}${JUPYTERHUB_STATUS_URL}/3"
curl -X POST -H "Authorization: token ${JUPYTERHUB_API_TOKEN}" ${SERVER}${JUPYTERHUB_STATUS_URL}/3
sleep 2
jupyterhub-singleuser ${@} &
child=$!
echo ".......... Wait for ${child}"
wait "$child"
