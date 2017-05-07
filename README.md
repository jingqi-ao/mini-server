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
