FROM alpine
VOLUME /sys/fs/cgroup
RUN apk add --no-cache nginx openrc openssl openssh \
	&& echo 'root:ft' | chpasswd \
	&& adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout localhost.key \
		-out localhost.crt  -subj "/C=RU/CN=ksinistr-CA" \
	&& cp localhost.crt /etc/ssl/certs/localhost.crt \
	&& cp localhost.key /etc/ssl/private/localhost.key \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status
COPY nginx.conf /etc/nginx/
COPY index.html /www
WORKDIR /tmp/
COPY start.sh ./
RUN chmod 755 ./start.sh
EXPOSE 80 443 22
ENTRYPOINT ["./start.sh"]
