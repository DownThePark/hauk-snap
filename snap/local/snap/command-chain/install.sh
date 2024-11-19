#!/bin/bash

source $SNAP/etc/defaults

# Set default configuration values for this snap
initialize_snap_configuration() {
  snapctl set ports.http=$DEFAULT_HTTP_PORT
  snapctl set ports.https=$DEFAULT_HTTPS_PORT
  snapctl set ssl.enabled=$DEFAULT_SSL_ENABLED
  snapctl set ssl.cert=$DEFAULT_SSL_CERT
  snapctl set ssl.key=$DEFAULT_SSL_KEY
}

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Create folders
  mkdir $SNAP_DATA/etc
  mkdir $SNAP_DATA/ssl

  # config.php
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php
  sed -i "s#/etc/hauk#$(dirname $SNAP_DATA)/current/etc#g" $SNAP_DATA/etc/config.php

  # Generate self-signed certificate
  openssl req -x509 -newkey rsa:4096 -keyout $SNAP_DATA/ssl/key.pem -out $SNAP_DATA/ssl/cert.pem -sha256 -days 3650 -nodes -subj "/C=/ST=/L=/O=/OU=/CN=hauk.example.com"
  chmod 600 $SNAP_DATA/ssl/key.pem
}

initialize_snap_configuration
initialize_snap_data
