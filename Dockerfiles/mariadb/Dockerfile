FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache mariadb \
    mariadb-client

ADD ./configure.sh /configure.sh
RUN chmod 755 /configure.sh

EXPOSE 3306

ENTRYPOINT ["sh", "./configure.sh"]