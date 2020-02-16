#!/bin/sh

# Control postfix start/stop/reload based on received signals, and use this
# script with Supervisor to detect and reload if postfix goes down.
#
# Based on: https://gist.github.com/chrisnew/b0c1b8d310fc5ceaeac4
#
# Supervisord config snippet for postfix-wrapper:
#
# [program:postfix]
# process_name = postfix
# command = /path/to/postfix-wrapper.sh
# startsecs = 0
# autorestart = false
#

# Execute the postfix control commands on received signals
trap "postfix stop" SIGINT
trap "postfix stop" SIGTERM
trap "postfix reload" SIGHUP

# Start postfix
postfix start

# Check every 5 seconds if postfix is still alive
PID_FILE="/var/spool/postfix/pid/master.pid"
while true; do
  sleep 5
  # Stop this script if no PID file is available
  if [ ! -f "$PID_FILE" ]; then
    break;
  else
    # Or if the numeric PID in the file can't receive a signal
    PID="$(cat $PID_FILE | sed 's/[^0-9]*//g')"
    if ! kill -0 "$PID" 2>/dev/null; then
      break;
    fi
  fi
done
