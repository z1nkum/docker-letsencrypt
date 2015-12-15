#!/bin/bash

# Add a cron line with details of the current user etc

echo "Configuring cron..."
echo "DOMAINS: " $DOMAINS
echo "EMAIL: " $EMAIL

# Fetch new certificates on the first of each month at midnight
line="0 0 1 * * DOMAINS='$DOMAINS' EMAIL=$EMAIL /letsencrypt/fetch_certs.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -

# Save new certificates on the second of each month at midnight
line="0 0 2 * * DOMAINS='$DOMAINS' /letsencrypt/save_certs.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -

crontab -l

if [ "$ENV" -eq "STAGING" ]; then
    echo "server = https://acme-staging.api.letsencrypt.org/directory" >> /etc/letsencrypt/cli.ini
fi    

# Start cron
echo "Starting cron..."
cron &

echo "Starting nginx..."
nginx -g 'daemon off;'
