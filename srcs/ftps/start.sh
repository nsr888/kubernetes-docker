#!/bin/sh
addgroup -g 433 -S ft
adduser -u 431 -D -G ft -h /home/ft -s /bin/false ft
echo "ft:ft" | /usr/sbin/chpasswd
chown ft:ft /home/ft/ -R
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
