
# Hauk Snap
[![hauk](https://snapcraft.io/hauk/badge.svg)](https://snapcraft.io/hauk)

## Introduction

This is a community-developed snap for [Hauk](https://github.com/bilde2910/Hauk) (a fully open source, self-hosted location sharing service). It comes packaged with Apache2, PHP and memcached, all configured to work perfectly together, allowing you to easily install and run a self-hosted Hauk instance.

## Installation
[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/hauk)

Hauk can be installed from the Snap Store using the following command:

    sudo snap install hauk

## Configuration

#### Hauk Configuration

The configuration file for Hauk is available at: `/var/snap/hauk/current/etc/config.php`

#### Web Server Configuration

To set the listening address (default: `0.0.0.0`):
```
sudo snap set hauk listen.address=<address>
```

To set the HTTP port (default: `80`):
```
sudo snap set hauk listen.http=<port>
```

To set the HTTPS port (default: `443`):
```
sudo snap set hauk listen.https=<port>
```

To enable or disable HTTPS support (default: `false`):
```
sudo snap set hauk ssl.enabled=<true|false>
```
