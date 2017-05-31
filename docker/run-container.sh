#!/bin/bash

set -ex

if [ -z "$IMAGE_FULL_NAME" ]; then
    echo "No IMAGE_FULL_NAME"
    exit 1
fi

if [ -z "$RESPONSE_STRING" ]; then
    echo "No RESPONSE_STRING. Generate a random one"
    RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    RESPONSE_STRING="Reponse: "$RANDOM_STRING
    echo "RESPONSE_STRING: "$RESPONSE_STRING
fi

if [ -z "$HTTP_MODE" ]; then
    HTTP_MODE=http
    echo "No HTTP_MODE. USE "${HTTP_MODE}
fi

if [ -z "$HOST_PORT" ]; then
    HOST_PORT=3000
    echo "No HOST_PORT. USE "${HOST_PORT}
fi

if [ -z "$CONTAINER_NAME" ]; then
    CONTAINER_NAME=mini-server
    echo "No CONTAINER_NAME. USE "${CONTAINER_NAME}
fi

if [ -z "$REDIRECT_TARGET_URL" ]; then
    REDIRECT_TARGET_URL=https://www.google.com/
    echo "No REDIRECT_TARGET_URL. USE "${REDIRECT_TARGET_URL}
fi

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

docker pull $IMAGE_FULL_NAME

docker run -d \
    -p $HOST_PORT:3000 \
    --restart on-failure \
    --name $CONTAINER_NAME \
    -e "CUSTOM_RESPONSE_STRING=$RESPONSE_STRING" \
    -e "HTTP_MODE=$HTTP_MODE" \
    -e "REDIRECT_TARGET_URL=$REDIRECT_TARGET_URL" \
    $IMAGE_FULL_NAME
