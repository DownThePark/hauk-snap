#!/bin/bash

# Placeholder
#echo "Starting NGINX..."

$SNAP/bin/setpriv.sh $SNAP/usr/sbin/nginx -c $SNAP/etc/nginx/nginx.conf
