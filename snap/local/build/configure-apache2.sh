#!/bin/bash

# Copy apache configuration from build-packages step
rm -r etc/apache2
cp -r /etc/apache2 etc/

# Custom apache2.conf
cat << 'EOF' > etc/apache2/apache2.conf
ServerName localhost
HostnameLookups Off
KeepAlive On
Timeout 300
MaxKeepAliveRequests 100
KeepAliveTimeout 5
ErrorLog /dev/null
DefaultRuntimeDir ${APACHE_RUN_DIR}
PidFile ${APACHE_PID_FILE}

Listen ${HTTP_PORT}
<IfDefine SSLEnabled>
    Listen ${HTTPS_PORT}
</IfDefine>

<Directory />
    Require all denied
</Directory>

<Directory ${HTML}>
    Require all granted
</Directory>

AccessFileName .htaccess
<FilesMatch "^\.ht">
    Require all denied
</FilesMatch>

<VirtualHost *:${HTTP_PORT}>
    DocumentRoot ${HTML}
</VirtualHost>

<VirtualHost *:${HTTPS_PORT}>
    DocumentRoot ${HTML}

    SSLEngine on
    SSLCertificateFile      ${SSL_CERT}
    SSLCertificateKeyFile   ${SSL_KEY}

    <FilesMatch "\.(?:cgi|shtml|phtml|php)$">
        SSLOptions +StdEnvVars
    </FilesMatch>
</VirtualHost>

IncludeOptional conf-enabled/*.conf
IncludeOptional mods-enabled/*.conf
IncludeOptional mods-enabled/*.load
EOF

# Enable SSL mod
pushd etc/apache2/mods-enabled
ln -sf ../mods-available/socache_shmcb.load .
ln -sf ../mods-available/ssl.conf .
ln -sf ../mods-available/ssl.load .
popd
sed -i "s#/usr/share/apache2/ask-for-passphrase#\$\{SNAP}/usr/share/apache2/ask-for-passphrase#g" etc/apache2/mods-available/ssl.conf
