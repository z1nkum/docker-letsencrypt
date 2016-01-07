#!/bin/bash

# Add a cron line with details of the current user etc

echo "Configuring cron..."
echo "DOMAINS: " $DOMAINS
echo "EMAIL: " $EMAIL
echo "RC_NAMES: " $RC_NAMES
# On the first of each month at midnight, fetch and save certs + restart pods.

line="0 0 1 * * RC_NAMES='$RC_NAMES' DOMAINS='$DOMAINS' EMAIL=$EMAIL /letsencrypt/refresh_certs.sh >> /var/log/cron-encrypt.log"
(crontab -u root -l; echo "$line" ) | crontab -u root -


if [ -n "${LETSENCRYPT_ENDPOINT+1}" ]; then
    echo "server = $LETSENCRYPT_ENDPOINT" >> /etc/letsencrypt/cli.ini
fi

# Start cron
echo "Starting cron..."
touch /var/log/cron.log
rsyslogd
cron &

echo "Starting nginx..."
nginx -g 'daemon off;'
