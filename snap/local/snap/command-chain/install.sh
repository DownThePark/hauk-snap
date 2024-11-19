#!/bin/bash

# Set default configuration values for this snap
initialize_snap_configuration() {
  snapctl set ports.http="80"
  snapctl set ports.https="443"
  snapctl set ssl.enabled="false"
  snapctl set ssl.cert="$(dirname $SNAP_DATA)/current/ssl/cert.pem"
  snapctl set ssl.key="$(dirname $SNAP_DATA)/current/ssl/key.pem"
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
