#!/bin/bash

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Configuration
  mkdir $SNAP_DATA/etc
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php

  # Lock
  mkdir $SNAP_DATA/lock

  # Logs
  mkdir $SNAP_DATA/log

  # Sockets
  mkdir $SNAP_DATA/run

  # Set permissions
  chown -R snap_daemon:snap_daemon $SNAP_DATA/etc
  chown -R snap_daemon:snap_daemon $SNAP_DATA/lock
  chown -R snap_daemon:snap_daemon $SNAP_DATA/log
  chown -R snap_daemon:snap_daemon $SNAP_DATA/run
}

initialize_snap_data
