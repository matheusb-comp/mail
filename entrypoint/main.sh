#!/bin/sh

echo "Running entrypoint: $@"

# Substitute env vars in the base db config files
sed -i 's/{{DB_URL}}/'"$DB_URL"'/g' /etc/postfix/pgsql.cf /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/{{DB_HOSTS}}/'"$DB_HOSTS"'/g' /etc/postfix/pgsql.cf /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/{{DB_USER}}/'"$DB_USER"'/g' /etc/postfix/pgsql.cf /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/{{DB_PASS}}/'"$DB_PASS"'/g' /etc/postfix/pgsql.cf /etc/dovecot/dovecot-sql.conf.ext
sed -i 's/{{DB_NAME}}/'"$DB_NAME"'/g' /etc/postfix/pgsql.cf /etc/dovecot/dovecot-sql.conf.ext

# Append the DB config in all the Postfix (hide tee stdout)
cat /etc/postfix/pgsql.cf | tee -a \
  /etc/postfix/vbox-domains.cf \
  /etc/postfix/vbox-maps.cf \
  /etc/postfix/valias-maps.cf > /dev/null

exec $@
