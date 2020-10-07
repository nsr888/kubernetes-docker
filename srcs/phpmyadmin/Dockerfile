FROM alpine
VOLUME /sys/fs/cgroup
RUN \
	apk add --no-cache nginx openrc wget php7 php7-fpm php7-mysqli php7-zlib \
	php7-curl php7-mbstring php7-json php7-session bash curl \
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
	curl -SL http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	| tar xzC /www --strip-components=1 \
	&& mkdir tmp \ 
	&& chmod 777 tmp \
	&& mv config.sample.inc.php config.inc.php \
	&& sed -i "s/host'] = 'localhost'/host'] = 'mysql'/" config.inc.php \
	&& sed -i "s/fish_secret'] = ''/fish_secret'] = \
		'ZVbK:O:[eY8-,LHtlErX}41a=6YneRoS'/" config.inc.php
WORKDIR /tmp/
COPY ./start.sh ./
RUN chmod 755 ./start.sh
EXPOSE 5000
ENTRYPOINT ./start.sh
