#!/bin/sh
set -e

# Crond will run in foreground. Log files can be found in /var/log/cron (default behaviour).
crond -x sch -n "$@"
