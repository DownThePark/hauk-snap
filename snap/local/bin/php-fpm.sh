#!/bin/bash

$SNAP/usr/sbin/php-fpm8.3 --nodaemonize -R --fpm-config $SNAP/etc/php-fpm.conf
