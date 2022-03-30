#!/usr/bin/env bash

# ssb
echo 'Starting Peach Cloud!'
systemctl --user start go-sbot.service
systemctl --user start peach-web.service