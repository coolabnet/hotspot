#!/usr/bin/env bash

# portal
echo 'Downloading Portal'
curl -s https://api.github.com/repos/coolabnet/hotspot/releases/latest \
| grep "browser_download_url.*zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
rm -rf /usr/src/dist
unzip portal.zip
mv /usr/src/dist/* /usr/src/
# Installers
mkdir -p /usr/src/installers
wget https://f-droid.org/F-Droid.apk -O /usr/src/installers/fdroid.apk
wget https://manyver.se/apk -O /usr/src/installers/manyverse.apk
wget https://github.com/staltz/manyverse/releases/download/v0.2207.5-beta/manyverse-0.2207.5-beta-windows-x64-nsis-installer.exe -O /usr/src/installers/manyverse.exe
wget https://github.com/staltz/manyverse/releases/download/v0.2207.5-beta/Manyverse-0.2207.5-beta.dmg -O /usr/src/installers/manyverse.dmg
# 
# Python
echo 'Starting Python server'


## Next

# READ local JSON
LOCAL_VERSION= ($(cat /usr/local.json | jq '.tag_name'))
# Start captive-portal server
python /usr/src/captive-portal.py &
# Start redirect server
python /usr/src/redirect.py
# JSON API: https://api.github.com/repos/coolabnet/hotspot/releases/latest
wget https://api.github.com/repos/coolabnet/hotspot/releases/latest -O /usr/src/latest.json
LATEST_VERSION=($(cat /usr/src/latest.json | jq '.tag_name')) # or by asset id: '.assets[0].id'
# IF tag_name is different from local JSON
# Download zip
# IF Download is successful
# RM old dist
# UNZIP new dist
rm local.json
mv /usr/src/latest.json /usr/src/local.json

# JSON API: https://api.github.com/repos/staltz/manyverse/releases/latest
# IF tag_name is different from local JSON
# Download assets: apk, exe, dmg, tag.gz, deb

