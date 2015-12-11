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
