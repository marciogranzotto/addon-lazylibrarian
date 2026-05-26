#!/usr/bin/env bash
set -euo pipefail
cd lazylibrarian && docker build \
    --build-arg BUILD_FROM="lscr.io/linuxserver/lazylibrarian:amd64-latest" \
    --build-arg BUILD_ARCH=amd64 \
    --progress plain --no-cache \
    -t lazylibrarian-amd64 .
