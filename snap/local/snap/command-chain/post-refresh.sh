#!/bin/bash

source $SNAP/bin/get-current-configuration.sh
source $SNAP/bin/get-default-configuration.sh

# Add missing snap configurations (if any)
add_missing_configurations() {
  if [ -z "$LISTEN_ADDRESS" ] ; then
    snapctl set listen.address="$DEFAULT_LISTEN_ADDRESS"
  fi
  if [ -z "$LISTEN_HTTP" ] ; then
    snapctl set listen.http="$DEFAULT_LISTEN_HTTP"
  fi
  if [ -z "$LISTEN_HTTPS" ] ; then
    snapctl set listen.https="$DEFAULT_LISTEN_HTTPS"
  fi
  if [ -z "$SSL_ENABLED" ] ; then
    snapctl set ssl.enabled="$DEFAULT_SSL_ENABLED"
  fi
  if [ -z "$SSL_CERT" ] ; then
    snapctl set ssl.cert="$DEFAULT_SSL_CERT"
  fi
  if [ -z "$SSL_KEY" ] ; then
    snapctl set ssl.key="$DEFAULT_SSL_KEY"
  fi
}

# Migrate old snap configurations to new format (if any)
migrate_snap_configurations() {
  # Get old configurations
  local PORTS_HTTP="$(snapctl get ports.http)"
  local PORTS_HTTPS="$(snapctl get ports.https)"

  # Migrate to new format
  if [ ! -z "$PORTS_HTTP" ] ; then
    snapctl set listen.http="$PORTS_HTTP"
  fi

  if [ ! -z "$PORTS_HTTPS" ] ; then
    snapctl set listen.https="$PORTS_HTTPS"
  fi

  # Remove old configurations
  snapctl unset ports

}

add_missing_configurations
migrate_snap_configurations
