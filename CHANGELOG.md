# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- **Fix:** map `addon_config:rw` instead of the deprecated `config:rw`. The old
  mapping mounted the **entire Home Assistant config directory** at `/config`,
  and the LinuxServer base image runs `lsiown -R abc:abc /config` on every start
  — recursively chowning the whole HA config dir to uid 911 (mode 700). That
  broke other add-ons running as non-root (e.g. Claude Code lost access to its
  credentials and the HA config). `addon_config:rw` gives LazyLibrarian its own
  private `/config` at `/addon_configs/<slug>`, matching the documented storage
  layout, so the chown only ever touches the add-on's private dir
- Initial add-on wrapping `lscr.io/linuxserver/lazylibrarian` with Home Assistant Ingress
