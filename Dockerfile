FROM alpine:latest

RUN apk add --update --no-cache \
  supervisor \
  postfix \
  postfix-pgsql \
  dovecot \
  dovecot-lmtpd \
  dovecot-pop3d \
  dovecot-pgsql

COPY ./config/ /etc/

COPY ./entrypoint/ /entrypoint/

WORKDIR /app

# General configurations
RUN rm /etc/supervisord.conf && \
  mkdir -p /var/log/supervisor && \
  chmod -R 600 /etc/postfix && \
  mkdir -p /var/mail/virtual && \
  addgroup -g 5000 mailuser && \
  adduser -D -u 5000 -h /var/mail/virtual -s /sbin/nologin -G mailuser mailuser && \
  chown -R mailuser:mailuser /var/mail/virtual

RUN newaliases

# Postfix ports
# 25: SMTP
# 587: SMTP (SSL)
# 465: SMTP (SSL, deprecated)
EXPOSE 25 587 465

# Dovecot ports
#   24: LMTP
#  110: POP3 (StartTLS)
#  143: IMAP4 (StartTLS)
#  993: IMAP (SSL, deprecated)
#  995: POP3 (SSL, deprecated)
# 4190: ManageSieve (StartTLS)
EXPOSE 110 143 993 995 4190

ENTRYPOINT ["/entrypoint/main.sh"]

# Supervisor is PID 1, it will take care of starting everything else
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
