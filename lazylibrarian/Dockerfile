ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

ENV LANG=C.UTF-8

ARG BASHIO_VERSION=0.16.2
# hadolint ignore=DL3018,DL3003
RUN apk add --no-cache nginx jq bash curl tzdata \
    && curl -L -o /tmp/bashio.tar.gz "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
    && tar -xzf /tmp/bashio.tar.gz -C /tmp \
    && mv "/tmp/bashio-${BASHIO_VERSION}/lib" /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio*

COPY rootfs/ /

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

LABEL \
    io.hass.name="LazyLibrarian" \
    io.hass.description="Automated ebook and audiobook collection manager" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Marcio Granzotto <contato@automarcio.com.br>" \
    org.opencontainers.image.title="LazyLibrarian" \
    org.opencontainers.image.description="Automated ebook and audiobook collection manager" \
    org.opencontainers.image.authors="Marcio Granzotto <contato@automarcio.com.br>" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.source="https://github.com/marciogranzotto/addon-lazylibrarian" \
    org.opencontainers.image.documentation="https://github.com/marciogranzotto/addon-lazylibrarian/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
