#!/bin/bash

export HTTPS_MODE=https

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

docker stop mini-server || true
docker rm mini-server || true

docker run -d \
    -p $HOST_PORT:3000 \
    --restart on-failure \
    --name mini-server \
    -e "CUSTOM_RESPONSE_STRING=$RESPONSE_STRING" \
    -e "HTTP_MODE=$HTTP_MODE" \
    $IMAGE_FULL_NAME
