#!/bin/bash

# Check pfx file
# $ openssl pkcs12 -info -in ./pfx/server.pfx

rm -rf pfx
mkdir pfx

cd pfx

openssl pkcs12 -export -out server.pfx \
 -inkey ../server/server-key.pem \
 -in ../server/server.cert \
 -passout pass:123456

cd ..