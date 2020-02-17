#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Move to the entrypoint directory
cd $(dirname "$0")

# Export the default gateway IP
export DEFAULT_GATEWAY=$(ip route | awk '/default/ { print $3 }')

# Try exporting the Docker secrets for variables starting with 'SECRET_'
. ./export.sh "SECRET_"

# Export DATABASE_URL if not already exported
. ./database.sh "postgresql://"

# TODO: REFACTOR - Install make and use a makefile to build the config files
# Substitute the connection string in the config files
sed -i 's|{{DATABASE_URL}}|'"$DATABASE_URL"'|' \
  /etc/postfix/vbox-domains.cf \
  /etc/postfix/vbox-maps.cf \
  /etc/postfix/valias-maps.cf \
  /etc/dovecot/sql-main.conf.ext
# Substitute the SSL certificate locations in the config files
KEY="${TLS_KEY:-/etc/letsencrypt/privkey.pem}"
CERT="${TLS_CERT:-/etc/letsencrypt/fullchain.pem}"
sed -i 's|{{TLS_KEY}}|'"$KEY"'|' \
  /etc/postfix/main.cf \
  /etc/dovecot/conf.d/10-ssl.conf
sed -i 's|{{TLS_CERT}}|'"$CERT"'|' \
  /etc/postfix/main.cf \
  /etc/dovecot/conf.d/10-ssl.conf

# Go back to where the script was called
cd - > /dev/null 2>&1

# Continue with the execution of the commands received
echo "Running entrypoint: $@"
exec $@
