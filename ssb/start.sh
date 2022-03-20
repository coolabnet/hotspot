#!/usr/bin/env bash

# ssb
echo 'Starting ssb pub'
echo 'Cleaning up' # Necessary: https://github.com/cryptoscope/ssb/issues/124
rm -rf /root/.ssb-go/sublogs/shared-badger/
go-sbot &
sleep 10
echo 'POSTing ssb invite'
sbotcli invite create --uses 9999 > /var/www/html/invite.json
ID=($(sbotcli call whoami  | jq '.id' | tr -d '"'))
echo $ID
sbotcli publish about --name "P2P Pub" $ID
# Connect to room
# sbotcli call conn.replicate '@uMYDVPuEKftL4SzpRGVyQxLdyPkOiX7njit7+qT/7IQ=.ed25519'
# sbotcli call conn.connect 'net:hermies.club:8008~shs:uMYDVPuEKftL4SzpRGVyQxLdyPkOiX7njit7+qT/7IQ='

# apache
source /etc/apache2/envvars
/usr/sbin/apache2
sleep infinity
