#!/bin/sh

# Move to the script directory
cd $(dirname "$0")

echo "## Exporting variables from .env"
# Export all .env variables (assume .env is in the parent folder)
# From: https://stackoverflow.com/a/30969768
set -o allexport
# Dot is the POSIX standard for the bash 'source'
# http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#dot
. ./.env
set +o allexport

# TODO: REFACTOR - Use the swarm
docker run --rm -it -v "$(pwd):/app" mail:latest

# Init the Docker swarm (silently ignore error messages)
#docker swarm init > /dev/null 2>&1

#NAME="${1:-website}"
#echo "## Starting stack ${NAME}..."
# Also set the user and group numeric IDs for the database, and deploy the stack
#env USER_ID=$(id -u) USER_GROUP=$(id -g) \
#  docker stack deploy -c ./stack.yml "$NAME"
