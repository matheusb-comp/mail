#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Create database connection string, if not provided
if [ -z "$DATABASE_URL" ]; then
  if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ]; then
    echo "## ERROR: Set DB_HOST and DB_USER when DATABASE_URL is not set." >&2
    exit 1
  fi

  SCHEMA="${1:-postgresql://}"
  DB_PASS="${DB_PASS:+:$DB_PASS}"
  DB_PORT="${DB_PORT:+:$DB_PORT}"
  DB_NAME="${DB_NAME:+/$DB_NAME}"
  DB_QUERY="${DB_QUERY:+?$DB_QUERY}"
  URL="${SCHEMA}${DB_USER}${DB_PASS}@${DB_HOST}${DB_PORT}${DB_NAME}${DB_QUERY}"
  export DATABASE_URL="$URL"
fi
