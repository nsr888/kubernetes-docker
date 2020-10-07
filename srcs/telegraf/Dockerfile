FROM alpine
VOLUME /sys/fs/cgroup
RUN \
	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> \
	/etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache openrc telegraf@testing curl jq \
    && rm -f /var/cache/apk/* \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status
WORKDIR /etc/telegraf/
COPY telegraf.conf ./
WORKDIR /tmp/
COPY start.sh ./
RUN chmod 755 ./start.sh
ENTRYPOINT ./start.sh
