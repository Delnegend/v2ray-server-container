<div align="center">

# v2ray-server-container

**Self-host a VMess-over-WebSocket proxy in one container: an Alpine image with your config mounted, not baked in.**

[![License](https://img.shields.io/github/license/Delnegend/v2ray-server-container?style=flat-square)](LICENSE)

</div>

> **Archived.** Kept for reference; the container still builds and runs as described below.

## Quick Start

```bash
# 1. Own it: set a fresh UUID in config.json (the committed one is public),
#    keeping port 8081 aligned with docker-compose.yml
# 2. Build and start
docker compose up -d --build
# 3. Point any VMess client at <host>:8081 (transport: WebSocket, path: /);
#    watch it answer
docker logs v2ray
```

## Highlights

- **One container, two files of yours** — the Dockerfile builds v2ray itself, everything you own lives in `config.json` and `docker-compose.yml`.
- **Survives reboots unattended** — `restart: always`, Cloudflare DNS (1.1.1.1) baked in so it never waits on a captive portal's resolver.
- **One-line version bumps** — the compose build arg `V2RAY_VERSION` (currently 5.29.0).
- **Credential rotation without a rebuild** — `config.json` is a bind mount, so a new UUID takes effect on container restart.

## Layout

| File | Purpose |
|---|---|
| `Dockerfile` | Alpine + ca-certificates, downloads the pinned v2ray release, runs it against `/config.json` |
| `docker-compose.yml` | Build arg, port `8081:8081`, config bind mount, DNS, always-restart |
| `config.json` | A single VMess inbound on 8081 over WebSocket, `freedom` outbound — edit the UUID before use |

## License

[MIT](LICENSE)
