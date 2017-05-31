#!/bin/bash

if [ -z "$USER" ]; then
    echo "No USER."
    exit 1
fi

if [ -z "$REMOTE_VM" ]; then
    echo "No REMOTE_VM."
    exit 1
fi

if [ -z "$IMAGE_FULL_NAME" ]; then
    echo "No IMAGE_FULL_NAME."
    exit 1
fi

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o UserKnownHostsFile=/dev/null \
    ${USER}@${REMOTE_VM} -t "rm -rf mini-server && mkdir mini-server"

scp -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o UserKnownHostsFile=/dev/null \
 run-container.sh ${USER}@${REMOTE_VM}:~/mini-server

REMOTE_COMMAND=$(cat <<EOM
    export IMAGE_FULL_NAME=$IMAGE_FULL_NAME &&
     export RESPONSE_STRING=$RESPONSE_STRING &&
     export HTTP_MODE=$HTTP_MODE &&
     export HOST_PORT=$HOST_PORT &&
     export CONTAINER_NAME=$CONTAINER_NAME &&
     export REDIRECT_TARGET_URL=$REDIRECT_TARGET_URL &&
     cd mini-server &&
     ./run-container.sh
EOM
)

ssh -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o UserKnownHostsFile=/dev/null \
    ${USER}@${REMOTE_VM} -t $REMOTE_COMMAND
