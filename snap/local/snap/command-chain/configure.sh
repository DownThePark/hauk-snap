#!/bin/bash

source $SNAP/etc/defaults

# Configured value(s)
HTTP_PORT="$(snapctl get ports.http)"
HTTPS_PORT="$(snapctl get ports.https)"
SSL_ENABLED="$(snapctl get ssl.enabled)"
SSL_CERT="$(snapctl get ssl.cert)"
SSL_KEY="$(snapctl get ssl.key)"

configure_apache2() {
  # Check if HTTP port value is valid or not
  if ! expr "$HTTP_PORT" : '^[0-9]\+$' > /dev/null ; then
    echo "Error: \"$HTTP_PORT\" is not a numerical value" >&2
    exit 1
  fi
  if (($HTTP_PORT < 1 || $HTTP_PORT > 65535)) ; then
    echo "Error: \"$HTTP_PORT\" is not a valid port number"
    exit 1
  fi

  # HTTPS port
  if ! expr "$HTTPS_PORT" : '^[0-9]\+$' > /dev/null ; then
    echo "Error: \"$HTTPS_PORT\" is not a numerical value" >&2
    exit 1
  fi
  if (($HTTPS_PORT < 1 || $HTTPS_PORT > 65535)) ; then
    echo "Error: \"$HTTPS_PORT\" is not a valid port number"
    exit 1
  fi

  # Enable or disable HTTPS
  if [[ $SSL_ENABLED == 'true' ]] ; then
    $SNAP/bin/apache2.sh -t enable
  elif [[ $SSL_ENABLED == 'false' ]] ; then
    $SNAP/bin/apache2.sh -t disable
  else
    echo "Error: \"$SSL_ENABLED\" is an invalid value. It must be set to either true or false."
    exit 1
  fi

  # Check if certificate paths are valid
  if [[ ! -f $SSL_CERT ]] ; then
    echo "Error: \"$SSL_CERT\" is an invalid path."
    exit 1
  fi

  if [[ ! -f $SSL_KEY ]] ; then
    echo "Error: \"$SSL_KEY\" is an invalid path."
    exit 1
  fi

  snapctl set ports.http=$HTTP_PORT
  snapctl set ports.https=$HTTPS_PORT
  snapctl set ssl.enabled=$SSL_ENABLED
  snapctl set ssl.cert=$SSL_CERT
  snapctl set ssl.key=$SSL_KEY
  snapctl restart hauk.apache2
}

add_missing_values() {
  if [ -z "$HTTP_PORT"] ; then
    snapctl set ports.http=$DEFAULT_HTTP_PORT
  fi

  if [ -z "$HTTPS_PORT"] ; then
    snapctl set ports.https=$DEFAULT_HTTPS_PORT
  fi

  if [ -z "$SSL_ENABLED"] ; then
    snapctl set ssl.enabled=$DEFAULT_SSL_ENABLED
  fi

  if [ -z "$SSL_CERT"] ; then
    snapctl set ssl.cert=$DEFAULT_SSL_CERT
  fi

  if [ -z "$SSL_KEY"] ; then
    snapctl set ssl.key=$DEFAULT_SSL_KEY
  fi
}

configure_apache2
add_missing_values
