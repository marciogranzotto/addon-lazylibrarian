ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

ENV LANG=C.UTF-8

ARG BASHIO_VERSION=0.16.2
# hadolint ignore=DL3008,DL3003
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nginx jq bash curl tzdata ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o /tmp/bashio.tar.gz "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
    && tar -xzf /tmp/bashio.tar.gz -C /tmp \
    && mv "/tmp/bashio-${BASHIO_VERSION}/lib" /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio*

# Calibre CLI (calibredb / ebook-convert / ebook-meta) so LazyLibrarian can import
# finished books into a Calibre library and convert/inspect formats. The library's
# metadata.db must be maintained by calibredb, not by dropping files in. Pull a few
# Qt runtime libs explicitly and run headless via QT_QPA_PLATFORM=offscreen.
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        calibre \
        libxcb-cursor0 libxkbcommon0 libegl1 libopengl0 \
    && rm -rf /var/lib/apt/lists/*

# Run headless (QT_QPA_PLATFORM) and pin the LinuxServer abc user to uid/gid 1000
# so LazyLibrarian can write shared paths owned by 1000 — the Calibre library
# (/media/.../Calibre Library) and the Transmission download dir on /share — and
# stays consistent with the other add-ons on this host.
ENV QT_QPA_PLATFORM=offscreen \
    PUID=1000 \
    PGID=1000

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
