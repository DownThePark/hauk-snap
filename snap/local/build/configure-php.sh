#!/bin/bash

# Copy PHP configuration from build-packages step
rm -r etc/php
cp -r /etc/php etc/

# Enable various PHP mods
pushd etc/php/8.3/apache2/conf.d/
ln -s ../../mods-available/opcache.ini 10-opcache.ini
ln -s ../../mods-available/pdo.ini 10-pdo.ini
ln -s ../../mods-available/calendar.ini 20-calendar.ini
ln -s ../../mods-available/ctype.ini 20-ctype.ini
ln -s ../../mods-available/exif.ini 20-exif.ini
ln -s ../../mods-available/ffi.ini 20-ffi.ini
ln -s ../../mods-available/fileinfo.ini 20-fileinfo.ini
ln -s ../../mods-available/ftp.ini 20-ftp.ini
ln -s ../../mods-available/gettext.ini 20-gettext.ini
ln -s ../../mods-available/iconv.ini 20-iconv.ini
ln -s ../../mods-available/igbinary.ini 20-igbinary.ini
ln -s ../../mods-available/ldap.ini 20-ldap.ini
ln -s ../../mods-available/msgpack.ini 20-msgpack.ini
ln -s ../../mods-available/phar.ini 20-phar.ini
ln -s ../../mods-available/posix.ini 20-posix.ini
ln -s ../../mods-available/readline.ini 20-readline.ini
ln -s ../../mods-available/shmop.ini 20-shmop.ini
ln -s ../../mods-available/sockets.ini 20-sockets.ini
ln -s ../../mods-available/sysvmsg.ini 20-sysvmsg.ini
ln -s ../../mods-available/sysvsem.ini 20-sysvsem.ini
ln -s ../../mods-available/sysvshm.ini 20-sysvshm.ini
ln -s ../../mods-available/tokenizer.ini 20-tokenizer.ini
ln -s ../../mods-available/memcached.ini 25-memcached.ini
popd
