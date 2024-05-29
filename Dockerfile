FROM alpine:3.14

ARG YACE_VERSION="0.57.1"
ENV YACE_PORT="5000"
ENV YACE_CONFIG="/opt/yace/config.yml"

EXPOSE ${YACE_PORT}

WORKDIR /opt/yace

RUN apk add --no-cache wget tar tini && \
    adduser -D blaze

RUN wget -O yace.tar.gz https://github.com/nerdswords/yet-another-cloudwatch-exporter/releases/download/v${YACE_VERSION}/yet-another-cloudwatch-exporter_${YACE_VERSION}_Linux_x86_64.tar.gz && \
    tar -xzf yace.tar.gz && \
    rm yace.tar.gz

COPY config.yml .

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chown nobody:nobody /opt/yace && \
    chmod +x /usr/local/bin/entrypoint.sh

USER nobody

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
