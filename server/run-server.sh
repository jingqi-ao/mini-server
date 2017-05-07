#!/bin/bash

# CERT_URL
# KEY_URL

export HTTP_MODE=https
export CUSTOM_RESPONSE_STRING=${CUSTOM_RESPONSE_STRING:-server1}

node server.js