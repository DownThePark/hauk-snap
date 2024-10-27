#!/bin/bash

# Default value(s)
DEFAULT_HTTP_PORT=80

initialize_snap_configuration() {
  snapctl set ports.http=$DEFAULT_HTTP_PORT
}

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Configs
  mkdir $SNAP_DATA/etc
  cp $SNAP/etc/server.conf $SNAP_DATA/etc
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php
  sed -i "s#/etc/hauk#$(dirname $SNAP_DATA)/current/etc#g" $SNAP_DATA/etc/config.php

  # Sockets
  mkdir $SNAP_DATA/run
}

initialize_snap_configuration
initialize_snap_data
