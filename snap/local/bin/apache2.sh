#!/bin/bash

export APACHE_RUN_USER=snap_daemon
export APACHE_RUN_GROUP=snap_daemon
export APACHE_RUN_DIR=/var/apache2/run
export APACHE_LOCK_DIR=/var/apache2/lock
export APACHE_LOG_DIR=/var/apache2/log
export APACHE_PID_FILE=/var/apache2/run/apache2.pid

source $SNAP_DATA/etc/server.conf

if [ -z "$HTTP_PORT" ] ; then
  echo "Error: The HTTP_PORT value seems to be missing in $SNAP_DATA/etc/server.conf" >&2
  exit 1
fi

if ! expr "$HTTP_PORT" : '^[0-9]\+$' > /dev/null ; then
  echo "Error: \"$HTTP_PORT\" is not a valid HTTP port" >&2
  exit 1
fi

if [ ! -d /var/apache2 ] ; then
  mkdir /var/apache2
fi

if [ ! -d /var/apache2/etc ] ; then
  mkdir /var/apache2/etc
fi

if [ ! -d /var/apache2/run ] ; then
  mkdir /var/apache2/run
fi

if [ ! -d /var/apache2/lock ] ; then
  mkdir /var/apache2/lock
fi

if [ ! -d /var/apache2/log ] ; then
  mkdir /var/apache2/log
fi

cp $SNAP/etc/ports.conf /var/apache2/etc
cp $SNAP/etc/000-default.conf /var/apache2/etc

sed -i "s/LISTEN_PORT_HTTP/$HTTP_PORT/g" /var/apache2/etc/ports.conf
sed -i "s/LISTEN_PORT_HTTP/$HTTP_PORT/g" /var/apache2/etc/000-default.conf

$SNAP/usr/sbin/apache2 -k start
