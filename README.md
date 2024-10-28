
# Hauk Snap
[![hauk](https://snapcraft.io/hauk/badge.svg)](https://snapcraft.io/hauk)

## Introduction

This is a snap for [Hauk](https://github.com/bilde2910/Hauk), a fully open source, self-hosted location sharing service. It comes packaged with Apache2, PHP and memcached, all configured to work nicely together, allowing you to easily deploy and run a self-hosted Hauk instance.

## Installation
[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/hauk)

Hauk can be installed from the Snap Store using the following command:

    sudo snap install hauk

## Configuration

The configuration file for Hauk is available at: `/var/snap/hauk/current/etc/config.php`

#### Available snap configurations

This snap uses snapd's built in configuration utility, allowing you to easily modify the configuration of the web server.

To set the HTTP port (default: `80`)
```
sudo snap set hauk ports.http=<value>
```

To set the HTTPS port (default: `443`)
```
sudo snap set hauk ports.https=<value>
```

To enable or disable HTTPS support (default: `false`)
```
sudo snap set hauk ssl.enabled=<true|false>
```

To set the certificate path (default: `/var/snap/hauk/current/ssl/cert.pem`)
```
sudo snap set hauk ssl.cert=<path>
```

To set the private-key path (default: `/var/snap/hauk/current/ssl/key.pem`)
```
sudo snap set hauk ssl.key=<path>
```

