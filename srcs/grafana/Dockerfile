FROM alpine
VOLUME /sys/fs/cgroup
RUN \
	echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> \
	/etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache openrc syslog-ng grafana@testing\
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status
WORKDIR /usr/share/grafana/conf/provisioning/datasources
COPY ./datasources.yaml ./
WORKDIR /usr/share/grafana/conf/provisioning/dashboards
COPY ./dashboards.yaml ./
WORKDIR /var/lib/grafana/dashboards
COPY ./dashboards/* ./
WORKDIR	/tmp/
COPY start.sh ./
RUN chmod 755 ./start.sh
EXPOSE 3000
ENTRYPOINT ./start.sh
