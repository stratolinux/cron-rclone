#!/bin/bash
set -e

# Cleans up crontabs dir.
rm -rf /var/spool/cron/crontabs && mkdir -m 0644 -p /var/spool/cron/crontabs

# Check if there's a /etc/cron.d mount point and if yes, copy contents into crontabs.
if [ -d "/etc/cron.d" ]; then
  chmod 0644 /etc/cron.d/*
  cd /etc/cron.d
  list=`ls *`
  for c in $list; do
    echo "Adding /etc/cron.d/$c to cron"
  done
fi

# Check if there's a /etc/rclone.conf and if yes, link the file into .config/rclone.
if [ -f "/etc/rclone.conf" ]; then
  if [ ! -d "/root/.config/rclone" ]; then
    mkdir -p "/root/.config/rclone"
  fi
  ln -s "/etc/rclone.conf" "/root/.config/rclone/rclone.conf"
fi

# Check if $CRON_STRINGS env variable was provided; If yes than create cronjobs with contents
# of that variable.
if [ ! -z "$CRON_STRINGS" ]; then
  echo -e "$CRON_STRINGS\n" > /var/spool/cron/crontabs/CRON_STRINGS
fi

exec "$@"
