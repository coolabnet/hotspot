#!/usr/bin/env bash

# ssb
echo 'Downloading Portal'
curl -s https://api.github.com/repos/coolabnet/hotspot/releases/latest \
| grep "browser_download_url.*zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
unzip portal.zip
mv dist/* /var/www/html/
# apache
echo 'Starting Apache server'
source /etc/apache2/envvars
/usr/sbin/apache2
sleep infinity
