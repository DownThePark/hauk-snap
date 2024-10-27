#!/bin/bash

cp -a /etc/apache2/. etc/apache2/

sed -i "s#80#\$\{HTTP_PORT}#g" etc/apache2/ports.conf
sed -i "s#80#\$\{HTTP_PORT}#g" etc/apache2/sites-available/000-default.conf
