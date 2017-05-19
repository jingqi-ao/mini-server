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
    echo "No HTTP_MODE. USE http"
    HTTP_MODE=http
fi

if [ -z "$HOST_PORT" ]; then
    echo "No HOST_PORT. USE 3000"
    HOST_PORT=3000
fi

if [ -z "$CONTAINER_NAME" ]; then
    echo "No CONTAINER_NAME. USE mini-server"
    CONTAINER_NAME=mini-server
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
    $IMAGE_FULL_NAME
