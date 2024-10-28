#!/bin/bash

# Copy apache configuration from build-packages step
cp -a /etc/apache2/. etc/apache2/

# ports.conf
cat << 'EOF' > etc/apache2/ports.conf
Listen ${HTTP_PORT}

<IfDefine SSLEnabled>
  Listen ${HTTPS_PORT}
</IfDefine>
EOF

# 000-default.conf
sed -i "s#80#\$\{HTTP_PORT}#g" etc/apache2/sites-available/000-default.conf

# ssl-default.conf
sed -i "s#443#\$\{HTTPS_PORT}#g" etc/apache2/sites-available/default-ssl.conf
sed -i "s#/etc/ssl/certs/ssl-cert-snakeoil.pem#\$\{SSL_CERT}#g" etc/apache2/sites-available/default-ssl.conf
sed -i "s#/etc/ssl/private/ssl-cert-snakeoil.key#\$\{SSL_KEY}#g" etc/apache2/sites-available/default-ssl.conf
pushd etc/apache2/sites-enabled
ln -sf ../sites-available/default-ssl.conf .
popd

# Mods
pushd etc/apache2/mods-enabled
ln -sf ../mods-available/socache_shmcb.load .
ln -sf ../mods-available/ssl.conf .
ln -sf ../mods-available/ssl.load .
popd
sed -i "s#/usr/share/apache2/ask-for-passphrase#\$\{SNAP}/usr/share/apache2/ask-for-passphrase#g" etc/apache2/mods-available/ssl.conf
