#!/bin/bash

SOURCEDIR="/crontabs"

# Check if there's a /crontabs mount point and copy contents into cron.d
if [ -d "${SOURCEDIR}" ]; then
  cd "${SOURCEDIR}"
  list=`ls *`
  for c in $list; do
    echo "Copying $c to /etc/cron.d/"
    cp $c /etc/cron.d/
  done
  # crontabs must be owned by root and have 0644 permissions
  chown -R root:root /etc/cron.d/*
  chmod 0644 /etc/cron.d/*
fi
