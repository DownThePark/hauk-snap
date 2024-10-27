#!/bin/bash

# Configured value(s)
HTTP_PORT="$(snapctl get server.ports.http)"

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

  snapctl set server.ports.http=$HTTP_PORT
  snapctl restart hauk.apache2
}

configure_apache2
