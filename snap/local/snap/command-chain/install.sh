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
  # Configuration files
  mkdir $SNAP_DATA/etc
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php
  sed -i "s#/etc/hauk#$(dirname $SNAP_DATA)/current/etc#g" $SNAP_DATA/etc/config.php

  # Sockets
  mkdir $SNAP_DATA/run

  # Certificates
  mkdir $SNAP_DATA/ssl
  openssl req -x509 -newkey rsa:4096 -keyout $SNAP_DATA/ssl/key.pem -out $SNAP_DATA/ssl/cert.pem -sha256 -days 3650 -nodes -subj "/C=US/ST=/L=/O=/OU=/CN=hauk.example.com"
  chmod 700 $SNAP_DATA/ssl
}

initialize_snap_configuration
initialize_snap_data
