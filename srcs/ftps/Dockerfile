FROM alpine
EXPOSE 20 21 10090
WORKDIR /tmp/
RUN apk add --no-cache vsftpd openssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout localhost.key -out localhost.crt  -subj "/C=RU/CN=ksinistr-CA" \
	&& cp localhost.crt /etc/ssl/certs/localhost.crt \
	&& cp localhost.key /etc/ssl/private/localhost.key
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./start.sh ./
RUN chmod 755 start.sh
ENTRYPOINT ["./start.sh"]
