#!/bin/bash

CONFIG_PATH="$(dirname $SNAP_DATA)/current/etc"

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Configs
  mkdir $SNAP_DATA/etc
  cp $SNAP/etc/server.conf $SNAP_DATA/etc
  cp $SNAP/html/include/config-sample.php $SNAP_DATA/etc/config.php
  sed -i "s#/etc/hauk#$CONFIG_PATH#g" $SNAP_DATA/etc/config.php

  # Sockets
  mkdir $SNAP_DATA/run
}

initialize_snap_data
