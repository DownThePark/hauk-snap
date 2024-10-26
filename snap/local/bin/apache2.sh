#!/bin/bash

source $SNAP_DATA/etc/server.conf

export APACHE_RUN_USER=snap_daemon
export APACHE_RUN_GROUP=snap_daemon
export APACHE_RUN_DIR=/var/apache2/run
export APACHE_LOCK_DIR=/var/apache2/lock
export APACHE_LOG_DIR=/var/apache2/log
export APACHE_PID_FILE=/var/apache2/run/apache2.pid

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
