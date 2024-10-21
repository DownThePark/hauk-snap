#!/bin/bash

# Initialize contents for $SNAP_DATA
initialize_snap_data() {
  # Configuration
  mkdir $SNAP_DATA/etc

  # Logs
  mkdir $SNAP_DATA/log

  # Sockets
  mkdir $SNAP_DATA/run
}

initialize_snap_data
