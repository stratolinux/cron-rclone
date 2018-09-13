FROM centos:7.5.1804
MAINTAINER eric@stratolinux.com

RUN yum install -y curl rsync unzip wget man cronie

# Add rclone
RUN curl https://rclone.org/install.sh | bash
RUN if [ -f /root/.config/rclone/rclone.conf ]; then rm /root/.config/rclone/rclone.conf; fi

RUN mkdir -p /var/log/cron \
&&  mkdir -m 0644 -p /var/spool/cron/crontabs \
&& touch /var/log/cron/cron.log \
&& mkdir -m 0644 -p /etc/cron.d

ADD /scripts/cron.sh /
ADD /scripts/entrypoint.sh /
ADD /scripts/copy-crontab.sh /

RUN chmod +x /cron.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /copy-crontab.sh


ENTRYPOINT ["/entrypoint.sh"]
CMD ["/cron.sh"]
