#!/bin/bash

$SNAP/bin/setpriv.sh $SNAP/usr/sbin/php-fpm8.3 --nodaemonize --fpm-config $SNAP/etc/php-fpm.conf
