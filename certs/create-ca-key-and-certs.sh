#!/bin/bash

# How to check cert:
# $ openssl x509 -in ./ca/ca.cert -text -noout

rm -rf ca
mkdir ca

cd ca

openssl req \
    -nodes \
    -new -x509 \
    -days 3650 \
    -keyout ca-key.pem -out ca.cert \
    -subj "/C=US/ST=CA/L=San Francisco/O=JaoDevelop/OU=JaoDevelop/CN=www.jao-ca.com"

cd ..
