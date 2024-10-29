#!/bin/bash

export MEMCACHED_RUN_DIR=/tmp/memcached/run

if [ ! -d $MEMCACHED_RUN_DIR ] ; then
  mkdir -p $MEMCACHED_RUN_DIR
fi

$SNAP/usr/bin/memcached -s $MEMCACHED_RUN_DIR/memcached.sock -m 64 -u root
