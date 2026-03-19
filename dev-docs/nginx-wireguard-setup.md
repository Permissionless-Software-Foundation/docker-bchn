# BCHN Node Behind Firewall via Nginx + WireGuard

This note summarizes how to make a Bitcoin Cash Node (BCHN) reachable from the public internet when the node itself is behind a firewall and only reachable over a WireGuard tunnel.

## High-level architecture

- Public peers connect to `node.mysite.com:8333`.
- DNS for `node.mysite.com` points to a public host running Nginx.
- Nginx forwards raw TCP traffic on port `8333` through WireGuard to the private BCHN host (for example, `10.8.0.2:8333`).
- The BCHN node listens on `8333` and accepts inbound P2P connections.

## BCHN config notes

In `bitcoin.conf`:

- Keep `listen=1`.
- Keep `port=8333` (or use a different port consistently end-to-end).
- Set `externalip` to the **publicly reachable endpoint**, not the private WireGuard IP.

Recommended:

```conf
externalip=node.mysite.com
```

or explicitly:

```conf
externalip=node.mysite.com:8333
```

## Nginx requirement

Use Nginx `stream {}` TCP proxying (not `http {}`), since BCH P2P is raw TCP.

Example:

```nginx
stream {
  upstream bchn_backend {
    server 10.8.0.2:8333; # WireGuard IP of BCHN host
  }

  server {
    listen 8333;
    proxy_pass bchn_backend;
    proxy_timeout 1h;
    proxy_connect_timeout 10s;
  }
}
```

## Network checklist

- `node.mysite.com` resolves to the public IP of the Nginx host.
- Firewall allows inbound TCP `8333` to Nginx.
- Nginx host can reach the BCHN host over WireGuard on `10.8.0.2:8333`.
- BCHN is running and listening on `8333`.

## Important caveat

Cloudflare proxy mode ("orange cloud") should not be used for BCH P2P on `8333`; use DNS-only resolution so peers connect directly to your Nginx host.
