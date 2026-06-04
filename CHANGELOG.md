# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- **Add:** bundle the Calibre CLI (`calibredb`/`ebook-convert`/`ebook-meta`) so
  LazyLibrarian can import finished books straight into a Calibre library and
  convert formats. Runs headless via `QT_QPA_PLATFORM=offscreen`
- **Change:** pin the LinuxServer `abc` user to uid/gid `1000` (`ENV PUID/PGID`)
  so LazyLibrarian can write shared paths owned by `1000` — the Calibre library
  on `/media` and the Transmission download dir on `/share` — and stays
  consistent with the other add-ons on the host
- **Fix:** ingress UI now loads. The nginx proxy rewrites LazyLibrarian's
  host-absolute redirects/links to carry HA's per-session ingress prefix (via the
  `X-Ingress-Path` header), but was missing `absolute_redirect off` — so nginx
  re-absolutized every rewritten `Location` to its own internal listen address
  (`http://172.30.x.x:<port>/...`), which the browser can't reach. Added
  `absolute_redirect off`, plus a `location = /` that 302-redirects the bare
  ingress root to the app's webroot, so the UI works whether HA forwards `/` or
  `/lazylibrarian`. `30-config.sh` no longer renders the obsolete
  `%%ingress_entry%%` placeholder (the prefix is resolved per-request)
- **Fix:** map `addon_config:rw` instead of the deprecated `config:rw`. The old
  mapping mounted the **entire Home Assistant config directory** at `/config`,
  and the LinuxServer base image runs `lsiown -R abc:abc /config` on every start
  — recursively chowning the whole HA config dir to uid 911 (mode 700). That
  broke other add-ons running as non-root (e.g. Claude Code lost access to its
  credentials and the HA config). `addon_config:rw` gives LazyLibrarian its own
  private `/config` at `/addon_configs/<slug>`, matching the documented storage
  layout, so the chown only ever touches the add-on's private dir
- Initial add-on wrapping `lscr.io/linuxserver/lazylibrarian` with Home Assistant Ingress
