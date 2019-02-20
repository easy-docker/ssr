# Dockerfile for ShadowsocksR

FROM alpine:3.8

LABEL maintainer="Ghostry <ghostry.green@gmail.com>"

RUN apk update \
    && apk add --update python libsodium unzip wget \
    && rm -rf /var/cache/apk/*

# install ssr
RUN mkdir /ssr \
    && cd /ssr \
    && wget --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.zip -O /tmp/ssr.zip \
    && unzip -d /tmp /tmp/ssr.zip \
    && mv /tmp/shadowsocksr-3.2.2/shadowsocks /ssr/shadowsocks \
    && apk del unzip wget \
    && rm -rf /ssr/shadowsocks/*.sh \
    && rm -rf /tmp/*

# ssr default configuration
COPY shadowsocks.json /ssr/default.json

# ssr script
RUN cd /ssr/ \
  # start.sh
  && echo 'if [ ! -f "/etc/shadowsocks/config.json" ]; then cp /ssr/default.json /etc/shadowsocks/config.json;fi;python /ssr/shadowsocks/server.py -c /etc/shadowsocks/config.json' > start.sh \
  && chmod 775 start.sh

ENTRYPOINT ["sh", "/ssr/start.sh"]
