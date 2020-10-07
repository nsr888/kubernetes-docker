FROM alpine
VOLUME /sys/fs/cgroup
RUN \
	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> \
	/etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache openrc influxdb telegraf@testing curl \
    && rm -f /var/cache/apk/* \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status
WORKDIR /tmp/
COPY start.sh ./
RUN chmod 755 ./start.sh
EXPOSE 8086 8080
ENTRYPOINT ./start.sh
