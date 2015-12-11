#!/bin/bash

# $DOMAINS should contain all domains that this container is responsible for
# renewing.

# Inside /etc/letsencrypt/live/z.ployst.com we have:
#
# cert.pem  chain.pem  fullchain.pem  privkey.pem
#
# We want to convert fullchain.pem into proxycert
# and privkey.pem into proxykey and then save as a secret!

CERT_LOCATION='/etc/letsencrypt/live'

for i in "${DOMAINS[@]}"
do
    CERT=$(cat $CERT_LOCATION/$i/fullchain.pem | base64 --wrap=0)
    KEY=$(cat $CERT_LOCATION/$i/privkey.pem | base64 --wrap=0)
    DHPARAM=$(openssl dhparam 2048 | base64 --wrap=0)
    SECRET_NAME="certs-${i}"

    kubectl get secrets $SECRET_NAME && ACTION=replace || ACTION=create;

    cat << EOF | kubectl $ACTION -f -
{
 "apiVersion": "v1",
 "kind": "Secret",
 "metadata": {
   "name": "$SECRET_NAME",
   "namespace": "default"
 },
 "data": {
   "proxycert": "$CERT",
   "proxykey": "$KEY",
   "dhparam": "$DHPARAM"
 }
}
EOF
done
