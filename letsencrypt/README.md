# letsencrypt-kubernetes

A docker image suitable for requesting new certifcates from letsencrypt,
and storing them in a secret on kubernetes.


## Purpose

To provide an application that owns certificate requesting and storing.

 - To serve acme requests to letsencrypt (given that you direct them to this
   container)
 - To regularly (monthly) ask for new certificates.
 - To store those new certificates in a secret on kubernetes.

## Useful commands

### Generate a new set of certs

Once this container is running you can generate new certificates using:

kubectl exec -it <container> /bin/bash -- -c 'EMAIL=fred@fred.com DOMAINS=example.com foo.example.com ./fetch_certs.sh'


### Save the set of certificates as a secret

kubectl exec -it <container> /bin/bash -- -c 'DOMAINS=example.com foo.example.com ./save_certs.sh'


## Environment variables:

 - EMAIL - the email address to obtain certificates on behalf of.
 - DOMAINS - a space separated list of domains to obtain a certificate for.
 - LETSENCRYPT_ENDPOINT
   - If set, will be used to populate the /etc/letsencrypt/cli.ini file with
     the given server value. For testing use
     https://acme-staging.api.letsencrypt.org/directory
 - RC_NAMES - a space separated list of RC's whose pods to destroy after a
   certificate save.
 - SECRET_NAME - the name to save the secrets under
