#!/bin/bash

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Configuration
  mkdir $SNAP_DATA/etc
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php

  # Logs
  mkdir $SNAP_DATA/log

  # Sockets
  mkdir $SNAP_DATA/run

  # NGINX data
  mkdir -p $SNAP_DATA/var/lib/nginx

  # Set permissions
  chown -R snap_daemon:snap_daemon $SNAP_DATA/etc
  chown -R snap_daemon:snap_daemon $SNAP_DATA/log
  chown -R snap_daemon:snap_daemon $SNAP_DATA/run
  chown -R snap_daemon:snap_daemon $SNAP_DATA/var/lib/nginx
}

initialize_snap_data
