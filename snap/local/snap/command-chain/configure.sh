#!/bin/bash

source $SNAP/bin/get-current-configuration.sh

# Set configurations for apache2
configure_apache2() {
  # Check if HTTP port value is valid or not
  if ! expr "$LISTEN_HTTP" : '^[0-9]\+$' > /dev/null ; then
    echo "Error: \"$LISTEN_HTTP\" is not a numerical value" >&2
    exit 1
  fi
  if (($LISTEN_HTTP < 1 || $LISTEN_HTTP > 65535)) ; then
    echo "Error: \"$LISTEN_HTTP\" is not a valid port number" >&2
    exit 1
  fi

  # Check if HTTPS port value is valid or not
  if ! expr "$LISTEN_HTTPS" : '^[0-9]\+$' > /dev/null ; then
    echo "Error: \"$LISTEN_HTTPS\" is not a numerical value" >&2
    exit 1
  fi
  if (($LISTEN_HTTPS < 1 || $LISTEN_HTTPS > 65535)) ; then
    echo "Error: \"$LISTEN_HTTPS\" is not a valid port number" >&2
    exit 1
  fi

  # Enable or disable HTTPS
  if [[ $SSL_ENABLED == 'true' ]] ; then
    $SNAP/bin/apache2.sh -t enable
  elif [[ $SSL_ENABLED == 'false' ]] ; then
    $SNAP/bin/apache2.sh -t disable
  else
    echo "Error: \"$SSL_ENABLED\" is an invalid value. Valid values are: true, false" >&2
    exit 1
  fi

  snapctl set listen.address=$LISTEN_ADDRESS
  snapctl set listen.http=$LISTEN_HTTP
  snapctl set listen.https=$LISTEN_HTTPS
  snapctl set ssl.enabled=$SSL_ENABLED
  snapctl set ssl.cert=$SSL_CERT
  snapctl set ssl.key=$SSL_KEY
  snapctl restart hauk.apache2
}

configure_apache2
