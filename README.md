# Mini Server

Provide a mini functional http/https server for cloud services

## Certificates

Folder: certs

Including
- Generate CA (only root, no intermediate issuers) private key and certificate

```
$ create-ca-key-and-certs.sh
```

- Generate server private key and certificate. Server's certificate is signed by root's certificate

```
$ create-server-key-and-certs.sh
```

## Mini server

Folder: server


## Docker and deploy

Folder: docker

Build image

```

# Note: there is no tag. Tag will be read from package.json automatically
$ export REMOTE_IMAGE_FULL_NAME=REGISTRY/mini-server
$ ./build-image.sh

```

Run the container on the local machine

```

export IMAGE_FULL_NAME=mini-server:0.0.2
export HOST_PORT=443
export HTTP_MODE=https
export CONTAINER_NAME=mini-443
./run-container.sh

```

Deploy the image (container) to a remote VM

```

export USER=user
export REMOTE_VM=1.2.3.4
export IMAGE_FULL_NAME=REGISTRY/mini-server:0.0.1
export HOST_PORT=443
export HTTP_MODE=https
export CONTAINER_NAME=mini-443
./deploy-to-remote-vm.sh

```

