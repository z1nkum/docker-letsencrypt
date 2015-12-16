#!/bin/bash
set -e

/letsencrypt/fetch_certs.sh
/letsencrypt/save_certs.sh
/letsencrypt/recreate_pods.sh
