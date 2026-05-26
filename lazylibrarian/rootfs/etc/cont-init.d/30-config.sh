#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e
# ==============================================================================
# Home Assistant Add-on: LazyLibrarian
# Configures LazyLibrarian + nginx for ingress before services start
# ==============================================================================

CONFIG_INI=/config/config.ini

# Seed a minimal config.ini on first boot so http_root takes effect immediately.
if [ ! -f "$CONFIG_INI" ]; then
    bashio::log.info "Seeding initial LazyLibrarian config.ini"
    mkdir -p /config
    cat > "$CONFIG_INI" <<'EOF'
[General]
http_host = 127.0.0.1
http_port = 5299
http_root = lazylibrarian
http_look = bookstrap
EOF
fi

# Force http_host / http_port / http_root on every boot (nginx proxies to these).
bashio::log.info "Patching LazyLibrarian network settings"
python3 - "$CONFIG_INI" <<'PY'
import configparser, sys
p = sys.argv[1]
cfg = configparser.ConfigParser()
cfg.read(p)
if not cfg.has_section('General'):
    cfg.add_section('General')
cfg['General']['http_host'] = '127.0.0.1'
cfg['General']['http_port'] = '5299'
cfg['General']['http_root'] = 'lazylibrarian'
with open(p, 'w') as f:
    cfg.write(f, space_around_delimiters=True)
PY

# Render the nginx ingress template with HA's assigned port/interface.
INGRESS_PORT=$(bashio::addon.ingress_port)
INGRESS_INTERFACE=$(bashio::addon.ip_address)
INGRESS_ENTRY=$(bashio::addon.ingress_entry)

bashio::log.info "Ingress: ${INGRESS_INTERFACE}:${INGRESS_PORT} entry=${INGRESS_ENTRY}"
sed -i "s|%%port%%|${INGRESS_PORT}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%interface%%|${INGRESS_INTERFACE}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%ingress_entry%%|${INGRESS_ENTRY}|g" /etc/nginx/servers/ingress.conf
