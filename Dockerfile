FROM alpine:3.13.5

LABEL maintainer="FoRTu" \
maintainet.email="me@fortu.io" \
maintainer.website="https://github.com/FoRTu"

RUN apk add --no-cache samba-server=4.13.8-r0 samba-common-tools=4.13.8-r0 openssl

ADD start.sh /start.sh

RUN ["chmod", "+x", "/start.sh"]

CMD ["/start.sh"]
