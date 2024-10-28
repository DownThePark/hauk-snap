#!/bin/bash

cp -a /etc/apache2/. etc/apache2/

sed -i "s#80#\$\{HTTP_PORT}#g" etc/apache2/ports.conf
sed -i "s#80#\$\{HTTP_PORT}#g" etc/apache2/sites-available/000-default.conf

sed -i "s#443#\$\{HTTPS_PORT}#g" etc/apache2/ports.conf
sed -i "s#443#\$\{HTTPS_PORT}#g" etc/apache2/sites-available/default-ssl.conf
sed -i "s#/etc/ssl/certs/ssl-cert-snakeoil.pem#\$\{SSL_CERT}#g" etc/apache2/sites-available/default-ssl.conf
sed -i "s#/etc/ssl/private/ssl-cert-snakeoil.key#\$\{SSL_KEY}#g" etc/apache2/sites-available/default-ssl.conf
sed -i "s#/usr/share/apache2/ask-for-passphrase#\$\{SNAP}/usr/share/apache2/ask-for-passphrase#g" etc/apache2/mods-available/ssl.conf

ln -sf /var/apache2/live/default-ssl.conf etc/apache2/sites-enabled
ln -sf /var/apache2/live/socache_shmcb.load etc/apache2/mods-enabled/socache_shmcb.load
ln -sf /var/apache2/live/ssl.conf etc/apache2/mods-enabled/ssl.conf
ln -sf /var/apache2/live/ssl.load etc/apache2/mods-enabled/ssl.load
