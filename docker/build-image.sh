#!/bin/bash

# REMOTE_IMAGE_FULL_NAME

rm -rf build
mkdir build

cd build

cp -r ../../server/certs .
cp -r ../../server/package.json .
cp -r ../../server/server.js .

cp -r ../Dockerfile .

# download node
wget https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-x64.tar.xz
tar xf node-v6.10.3-linux-x64.tar.xz

VERSION=$(cat package.json | grep "version" | awk -F":" '{print $2}' | awk -F"\"" '{print $2}')

docker build --rm --tag mini-server:$VERSION . 

if [ -z "$REMOTE_IMAGE_FULL_NAME" ]; then
    echo "No need to upload to registry."
else
    echo "Upload as remote image: "$REMOTE_IMAGE_FULL_NAME
    docker tag mini-server:$VERSION $REMOTE_IMAGE_FULL_NAME:$VERSION
    docker push $REMOTE_IMAGE_FULL_NAME:$VERSION
fi

cd ..