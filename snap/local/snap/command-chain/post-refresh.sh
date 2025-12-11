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
}

# Remove outdated snap configurations (if any)
remove_outdated_configurations() {
  if [ ! -z "$(snapctl get ssl.cert)" ] ; then
    snapctl unset ssl.cert
  fi
  if [ ! -z "$(snapctl get ssl.key)" ] ; then
    snapctl unset ssl.key
  fi
}

add_missing_configurations
remove_outdated_configurations
