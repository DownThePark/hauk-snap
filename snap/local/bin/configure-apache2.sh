#!/bin/bash

# Copy apache configuration from build-packages step
rm -r etc/apache2
cp -r /etc/apache2 etc/

# Delete default virtual host
rm etc/apache2/sites-enabled/000-default.conf

# ports.conf
cat << 'EOF' > etc/apache2/ports.conf
Listen ${HTTP_PORT}

<IfDefine SSLEnabled>
  Listen ${HTTPS_PORT}
</IfDefine>
EOF

# hauk.conf
cat << 'EOF' > etc/apache2/sites-available/hauk.conf
<VirtualHost *:${HTTP_PORT}>
    DocumentRoot /var/www/html
</VirtualHost>

<VirtualHost *:${HTTPS_PORT}>
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile      ${SSL_CERT}
    SSLCertificateKeyFile   ${SSL_KEY}

    <FilesMatch "\.(?:cgi|shtml|phtml|php)$">
        SSLOptions +StdEnvVars
    </FilesMatch>
    <Directory /usr/lib/cgi-bin>
        SSLOptions +StdEnvVars
    </Directory>
</VirtualHost>
EOF

pushd etc/apache2/sites-enabled
ln -sf ../sites-available/hauk.conf .
popd

# Mods
pushd etc/apache2/mods-enabled
ln -sf ../mods-available/socache_shmcb.load .
ln -sf ../mods-available/ssl.conf .
ln -sf ../mods-available/ssl.load .
popd
sed -i "s#/usr/share/apache2/ask-for-passphrase#\$\{SNAP}/usr/share/apache2/ask-for-passphrase#g" etc/apache2/mods-available/ssl.conf

# Disable logging
sed '/{APACHE_LOG_DIR}\/\error.log/d' etc/apache2/apache2.conf
echo "ErrorLog /dev/null" >> etc/apache2/apache2.conf
