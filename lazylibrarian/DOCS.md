# Home Assistant Add-On for LazyLibrarian

LazyLibrarian follows authors and series, searches Usenet/torrent indexers (works
with Prowlarr/Jackett), sends to your download client (SABnzbd, NZBGet,
qBittorrent, Transmission, Deluge), and imports/renames ebooks and audiobooks.

This add-on wraps the
[linuxserver/lazylibrarian](https://github.com/linuxserver/docker-lazylibrarian)
Docker image and exposes it via Home Assistant Ingress.

## Installation

1. [Add the add-on repository](https://github.com/marciogranzotto/addons-repository)
   to Home Assistant.
2. Install the **LazyLibrarian** add-on.
3. Start the add-on (first boot creates the default config; the add-on then
   patches `http_root` and restarts once — this is expected).
4. Click **OPEN WEB UI** to open LazyLibrarian through HA Ingress.

## Configuration

```yaml
PUID: 0
PGID: 0
TZ: America/Sao_Paulo
```

### Option: `PUID` / `PGID`

User/group IDs for file ownership inside `/config`, `/share`, `/media`. Default
`0` (root) matches HA add-on conventions.

### Option: `TZ`

Timezone string, e.g. `America/Sao_Paulo` or `Europe/Berlin`. Affects scheduling
and log timestamps.

## Storage

| Add-on path | HA path        | Purpose                                  |
|-------------|----------------|------------------------------------------|
| `/config`   | `/addon_configs/<slug>` | LazyLibrarian's config and database |
| `/share`    | `/share`       | Recommended location for download client |
| `/media`    | `/media`       | Where finished ebooks are imported       |

Inside LazyLibrarian's web UI, set library/download paths to live under
`/media` or `/share` so they survive add-on rebuilds.

## How Ingress works here

LazyLibrarian listens on `127.0.0.1:5299` inside the container with
`http_root = lazylibrarian`. An nginx sidecar on the HA-assigned ingress port
proxies to LazyLibrarian and rewrites absolute URLs so the UI works behind HA's
ingress token URL.

## Changelog

See [CHANGELOG.md](../CHANGELOG.md) and GitHub Releases.
