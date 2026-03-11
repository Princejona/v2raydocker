FROM alpine:latest

RUN apk update && apk add --no-cache \
    wget \
    unzip \
    tzdata

# Kunin ang latest Xray (mas mabilis at updated kaysa pure v2ray)
ARG XRAY_VERSION=v26.2.6   # baguhin sa pinakabagong version sa https://github.com/XTLS/Xray-core/releases

RUN wget -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip" && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray.zip

# Config
COPY config.json /etc/xray/config.json

# Timezone (optional)
ENV TZ=Asia/Manila

# Port na ilalabas (Cloud Run ignores EXPOSE pero maganda ilagay)
EXPOSE 8080

CMD ["xray", "-c", "/etc/xray/config.json"]
