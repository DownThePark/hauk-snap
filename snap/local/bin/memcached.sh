#!/bin/bash

$SNAP/bin/setpriv.sh $SNAP/usr/bin/memcached -s $SNAP_DATA/run/memcached.sock -m 64 -u snap_daemon
