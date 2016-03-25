#!/bin/bash

if [ -z "$USER_ID" ]; then
  USER_ID=$(id -u www-data)
fi

usermod -u $USER_ID www-data

if [ "$1" = "cron" ]; then
  exec cron && tail -f /var/log/cron.log
fi

exec "$@"
