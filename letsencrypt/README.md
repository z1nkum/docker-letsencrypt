# letsencrypt-kubernetes

A docker image suitable for requesting new certifcates from letsencrypt,
and storing them in a secret on kubernetes.


## Purpose

To provide an application that owns certificate requesting and storing.

 - To serve acme requests to letsencrypt (given that you direct them to this
   container)
 - To regularly (monthly) ask for new certificates.
 - To store those new certificates in a secret on kubernetes.
 
