#!/usr/bin/env bash
set -euo pipefail
cd lazylibrarian && docker build \
    --build-arg BUILD_FROM="lscr.io/linuxserver/lazylibrarian:arm64v8-latest" \
    --build-arg BUILD_ARCH=aarch64 \
    --progress plain --no-cache \
    -t lazylibrarian-aarch64 .
