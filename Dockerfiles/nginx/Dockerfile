FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache nginx \
    openssl
RUN rm -rf /var/cache/apk/*

# install ssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/cloud-one-nade-la.duckdns.org.crt \
        -keyout /etc/nginx/ssl/cloud-one-nade-la.duckdns.org.key \
        -subj "/C=Fr/ST=IledeFrance/L=Paris/O=42 School/CN=cloud-one-nade-la.duckdns.org"

# configurer nginx
RUN mkdir -p /var/www/html
RUN  rm /etc/nginx/http.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

#demarrer nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]