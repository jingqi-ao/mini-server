FROM ubuntu:16.04

WORKDIR /mini-server

COPY server.js server.js
COPY package.json package.json
COPY certs certs/

COPY node-* node/

RUN export PATH=$PATH:/mini-server/node/bin && \
    npm install

ENTRYPOINT export PATH=$PATH:/mini-server/node/bin && \
    node server.js