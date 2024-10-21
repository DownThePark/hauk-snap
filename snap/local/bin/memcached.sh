#!/bin/bash

$SNAP/usr/bin/memcached -d -s $SNAP_DATA/run/memcached.sock -m 64 -u root
