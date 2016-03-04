#!/bin/bash

echo "Setting up CA Certs for libcurl/devtools..."

# make sure the default CA bundle is available
CURL_CA_BUNDLE_DIR=/etc/pki/tls/certs
export CURL_CA_BUNDLE=$CURL_CA_BUNDLE_DIR/ca-bundle.pem

if [ ! -d $CURL_CA_BUNDLE_DIR ]; then
  sudo mkdir -p /etc/pki/tls/certs
fi
if [ ! -f $CURL_CA_BUNDLE ]; then
  sudo wget -O $CURL_CA_BUNDLE https://curl.haxx.se/ca/cacert.pem
fi

sudo ln -fs $CURL_CA_BUNDLE $CURL_CA_BUNDLE_DIR/ca-bundle.crt
sudo chown -R $(whoami) /etc/pki/tls/certs 
