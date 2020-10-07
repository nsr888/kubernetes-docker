FROM alpine
VOLUME /sys/fs/cgroup
RUN apk add --no-cache openrc mysql mysql-client \
    && rm -f /var/cache/apk/* \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status

WORKDIR /tmp/
COPY start.sh users.sql wordpress.sql ./
RUN chmod 755 ./start.sh
EXPOSE 3306

ENTRYPOINT ["./start.sh"]
