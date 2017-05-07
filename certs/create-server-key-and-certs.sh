#!/bin/bash

# Check signing request
# $ openssl req -text -noout -verify -in server/server.csr

# How to check cert:
# $ openssl x509 -in ./server/server.cert -text -noout

rm -rf server
mkdir server

cd server

# Generate server private key
# openssl genrsa -out server-key.pem 2048

# Generate private key and signing request
openssl req -nodes \
    -newkey rsa:2048 \
    -keyout server-key.pem -out server.csr \
    -subj "/C=US/ST=CA/L=San Francisco/O=JaoDevelop/OU=JaoDevelop/CN=www.jao-server.com"

# Use CA to sign the cert
openssl x509 -req -days 3650 -sha1 \
    -CA ../ca/ca.cert -CAkey ../ca/ca-key.pem -CAcreateserial \
    -in server.csr -out server.cert

cd ..