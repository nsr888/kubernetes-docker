FROM alpine
VOLUME /sys/fs/cgroup
RUN \
	apk add --no-cache nginx openrc wget php7 php7-fpm php7-mysqli php7-zlib \
	php7-curl php7-mbstring php7-json php7-session bash mysql-client curl \
	&& adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www \
	&& mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel \
	&& rc-status
COPY nginx.conf /etc/nginx/
WORKDIR /www/
RUN \
	curl -SL https://wordpress.org/latest.tar.gz \
	| tar xzC /www --strip-components=1 \
	&& mv wp-config-sample.php wp-config.php \
	&& sed -i "s/database_name_here/wordpress/" wp-config.php \
	&& sed -i "s/username_here/ft/" wp-config.php \
	&& sed -i "s/password_here/ft/" wp-config.php \
	&& sed -i "s/localhost/mysql/" wp-config.php
WORKDIR /tmp/
COPY ./start.sh ./
RUN chmod 755 ./start.sh
EXPOSE 5050
ENTRYPOINT ./start.sh
