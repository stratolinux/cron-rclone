# cron-rclone

CentOS 7.5 based dockerfile that allows to register and execute
rclone/cron tasks with ease.

It can:
 - Mount cron jobs from a shared volume on host
 - Create cron jobs from environment variable

#### Environment variables:

* CRON_STRINGS - add cronjobs as environment variables. Example:
    ```
    CRON_STRINGS=* * * * * /any-command-you-wish
    ```
    You can put multiple commands in CRON_STRINGS. Just use "\n" for newline.

* CRON_TAIL - if defined cron log file will be read to STDOUT by tail. By default cron runs in foreground mode.

#### Mount cron files from host:

You can mount files from host as: /path/to/host/crontabs:/etc/cron.d, when container
starts, it will copy all files from /path/to/host/crontabs into /etc/cron.d

#### Where are my logs?
Cron debuging for scheduling is enabled, logs are in /var/log/cron

#### Usage example:

##### With cronjobs defined in folder mounted into container:
```
docker run -d \
-v /path/to/host/crontabs:/etc/cron.d \
-v /path/to/host/rclone.conf:/etc/rclone.conf \
stratolinux/cron-rclone
```

##### With cronjob defined via environment variable:
```
docker run -d \
-v /path/to/host/crontabs:/etc/cron.d \
-v /path/to/host/rclone.conf:/etc/rclone.conf \
-e 'CRON_STRINGS=* * * * * docker ps' \
stratolinux/cron-rclone
```

##### As a service in docker-compose.yml:
```
cron:
    image: stratolinux/cron-rclone
    volumes:
      - "/path/to/host/crontabs:/etc/cron.d"
      - "/path/to/host/rclone.conf:/etc/rclone.conf"
    environment:
      - CRON_STRINGS=* * * * * docker ps
```

#### Special thanks
This Dockerfile was inspired by: https://github.com/timonweb/docker-cron-swissknife,
many thanks to timonweb for the ideas.

#### Copyright
Copyright (c) 2018 Eric Young
