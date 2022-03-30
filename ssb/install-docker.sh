#!/bin/bash

# PeachCloud install script.
# Installs go-sbot and peach-web.



echo "[ determining host cpu architecture ]"
arch=$(uname -m)

echo $arch
pwd
if [[ $arch == 'amd64' ]] || [[ $arch == 'aarch64' ]]
then
  echo "[ installing arm64 binaries ]"
  # Copy the arm64 go-sbot binary into place.
  cp go-sbot_arm64 /usr/bin/go-sbot
  # Copy the arm64 peach-web binary into place.
  cp peach-web_arm64 /usr/bin/peach-web
elif [[ $arch == 'x86_64' ]]
then
  echo "[ installing x86_64 binaries ]"
  # Copy the x86_64 go-sbot binary into place.
  cp go-sbot_x86_64 /usr/bin/go-sbot
  # Copy the x86_64 peach-web binary into place.
  cp peach-web_x86_64 /usr/bin/peach-web
else
  echo "[ error: host architecture not recognised; expected arm64 or x86_64 ]"
  # Exit out of this script.
  exit 1
fi

echo "[ setting permissions for binaries ]"
# Allow the home user to execute the binaries.
chmod a+x /usr/bin/go-sbot
chmod a+x /usr/bin/peach-web



echo "[ creating the go-ssb directory ]"
mkdir ~/.ssb-go

echo "[ writing the go-sbot configuration file ]"
# The go-sbot will crash if this config file is not in place.
cat > ~/.ssb-go/config.toml << UNIT
# For details about go-sbot configuration, please visit the repo: https://github.com/cryptoscope/ssb
repo = "/home/$(whoami)/.ssb-go"
debugdir = ""
shscap = "1KHLiKZvAvjbY1ziZEHMXawbCEIM6qwjCDm3VYRan/s="
hmac = ""
hops = 2
lis = "127.0.0.1:8008"
wslis = ":8987"
debuglis = "localhost:6078"
localadv = true
localdiscov = true
enable_ebt = true
promisc = true
nounixsock = false
repair = true
UNIT



# Note that the go-sbot service is not started.
# This is to allow go-sbot to be configured via the peach-web
# interface before the go-sbot is started for the first time.

echo "[ creating directory for peach-web assets ]"
mkdir -p /usr/share/peach-web

echo "[ copying peach-web assets into place ]"
cp -r static /usr/share/peach-web

# echo "[ updating permissions for peach-web assets ]"
# chown -R $(whoami):www-data /usr/share/peach-web
#


echo "[ creating peachcloud configuration directory ]"
mkdir -p /var/lib/peachcloud

echo "[ settings permissions for peachcloud configuration directory ]"
# chown -R $(whoami):www-data /var/lib/peachcloud
chmod -R 775 /var/lib/peachcloud
