FROM alpine:latest

RUN apk add --update --no-cache \
  supervisor \
  postfix \
  postfix-pgsql \
  dovecot \
  dovecot-lmtpd \
  dovecot-pop3d \
  dovecot-pgsql

COPY ./config /etc

WORKDIR /app

# Supervisor configurations
RUN rm /etc/supervisord.conf && \
  mkdir -p /var/log/supervisor && \
  # Postfix configurations
  chmod -R 600 /etc/postfix && \
  newaliases && \
  # Dovecot convifgurations
  mkdir -p /var/mail/virtual && \
  addgroup -g 5000 mailuser && \
  adduser -D -u 5000 -h /var/mail/virtual -s /sbin/nologin -G mailuser \
    mailuser && \
  chown -R mailuser:mailuser /var/mail/virtual

# Postfix ports
# 25: SMTP
# 587: SMTP (SSL)
# 465: SMTP (SSL, deprecated)
# Dovecot ports
# 110: POP3 (StartTLS)
# 143: IMAP4 (StartTLS)
# 993: IMAP (SSL, deprecated)
# 995: POP3 (SSL, deprecated)
EXPOSE 25 587 465 110 143 993 995

# Export Docker secrets and build config files
ENTRYPOINT ["/etc/entrypoint/main.sh"]

# Supervisor is PID 1, it will take care of starting everything else
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
