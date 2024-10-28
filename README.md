
# Hauk Snap
[![hauk](https://snapcraft.io/hauk/badge.svg)](https://snapcraft.io/hauk)

## Introduction

This is a snap for Hauk. It comes packaged with packaged with Apache2, PHP and memcached, all nicely configured together, allowing you to deploy and run Hauk very easily.

## Installation
[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/hauk)

This snap can be installed from the Snap Store using the following command:

    sudo snap install hauk

## Configuration

The configuration file for Hauk is available at: `$SNAP_DATA/etc/config.php`

This snap also utilizes snapd's built in configuration utility, allowing you to modify the configuration of the web server very easily.

#### Available snap configurations

Change the default HTTP port (default: 80)
```
sudo snap set hauk ports.http=<value>
```

Change the default HTTPS port (default: 443)
```
sudo snap set hauk ports.https=<value>
```

Enable or disable HTTPS support (default: false)
```
sudo snap set hauk ssl.enabled=<true|false>
```

Set certificate path (default: $SNAP_DATA/ssl/cert.pem)
```
sudo snap set hauk ssl.cert=<path>
```

Set private key path (default: $SNAP_DATA/ssl/key.pem)
```
sudo snap set hauk ssl.key=<path>
```

