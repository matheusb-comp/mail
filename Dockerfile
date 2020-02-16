FROM alpine:latest

RUN apk add --update --no-cache \
  supervisor \
  postfix \
  postfix-pgsql

COPY ./config/ /etc/

COPY ./entrypoint/ /entrypoint/

WORKDIR /app

# General configurations
RUN rm /etc/supervisord.conf && \
  mkdir -p /var/log/supervisor && \
  chmod -R 600 /etc/postfix

RUN newaliases

ENTRYPOINT ["/entrypoint/main.sh"]

# Supervisor is PID 1, it will take care of starting everything else
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
