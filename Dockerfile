FROM alpine:latest

LABEL maintainer Delnegend <kien@delnegend.com>

ARG V2RAY_VERSION

RUN apk add --no-cache --update ca-certificates tzdata && update-ca-certificates

RUN apk add --no-cache --update --virtual wget unzip && \
    wget -O /tmp/v2ray-$V2RAY_VERSION.zip https://github.com/v2fly/v2ray-core/releases/download/v$V2RAY_VERSION/v2ray-linux-64.zip && \
    mkdir -p /opt /v2ray && \
    unzip /tmp/v2ray-$V2RAY_VERSION.zip -d /opt && \
    rm /tmp/v2ray-$V2RAY_VERSION.zip

RUN chmod +x /opt/v2ray

CMD ["/opt/v2ray", "run", "-c", "/config.json"]
