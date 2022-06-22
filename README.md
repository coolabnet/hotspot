# P2P Hotspot

[![balena deploy button](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/coolabnet/hotspot)


P2P Hotspot is a low-energy device that creates an access-point serving p2p applications, bridges and content. Software and content are automatically updated while online.

A team can easily monitor and give direct support to all devices (with granted consent) while online.

## Getting started

We'll need Internet connection for downloading latest software and content. But after initial setup, device can exist and be updated offline.

*Needed hardware:*

- Computer: Raspberry Pi 3 or 4
- Storage: class 10 micro sd with min 16Gb or SSD connected thru usb
- (if using SSD && acess-point) Wifi Dongle: a Wifi dongle compatible with the device

*Setup*

1. Click "[Deploy with Balena](https://www.balena.io/docs/learn/deploy/deploy-with-balena-button/)" button
1. Create free Balena account
1. Set community environmental variables (wifi acess point name, wifi password, device name on network, community name, anguage, content repository address, map-tiles links)
1. Download project image
1. Burn image to micro sd or usb SSD
1. Plug storage into device
1. Plug device to power supply
1. Connect to the Internet thru an Ethernet cable
1. Check Balena dashboard if device is online
1. Wait for device to update it's software on Balena dashboard
1. Your device is ready!

## Usage

1. On a phone or computer search for WiFi access point and connect
1. Captive-portal with portal should pop-up, if not go to [10.42.0.1:8081](http://10.42.0.1:8081)
1. Follow guides and install tools on user devices

## Software stack

### Operating System

Meant to run on [Balena](https://balena.io), which enables easily composing service blocks on a performant container-based operating system. Advantages:

- [Balena Hub](https://hub.balena.io/) has a growing number of out-of-the-box apps
- [Balena Cloud](https://balena-cloud.com/) is free as long as project is published and used from Balena Hub
- simple migration from existing docker/docker-compose stack
- lightweight container-based operating system
- support for various types of single-board-computers and architectures
- over-the-air-updates
- small self-updating images
- per-device release pinning
- bulk monitoring of all devices and their services
- remote access to all devices and services via web terminal
- ssh tunnel and remote support

### Service Stack

- **Wifi**: creates a WiFi Access-Point with a Captive-portal redirecting user to portal application
- **Portal**: application which onboards new users and links to content and services
- **SSB-Pub**: [Secure Scuttlebut's](https://scuttlebutt.nz/) distributed database that connects automatically to a room and pub outside the local network (on the Internet)
- **Distributed File System**: automatically updates content if online through p2p sync using [IPFS](https://ipfs.io/)
## Extending
- Support more simultaneous users and extend wifi range with a router
- Extend router's wifi range by setting up a mesh network with your neighbors

## TODO

- Make it work offline
- Portal work on port 80
- Have Internet block work
- Optionally password protect Internet access
- Add p2p installer and browser applications ([Dat Installer](https://github.com/staltz/dat-installer) and [Agregore Browser](https://agregore.mauve.moe/) for example)
- Run an [F-Droid repository](https://gitlab.com/fdroid/wiki/-/wikis/List-of-F-Droid-repositories)
- Add service that scrapes latest apks and installers and serves them as F-droid and Dat-Installer repositories
- Have the pub publish an about photo
- Integrate [Peach Cloud](http://peachcloud.org/)
- Create an ARM32 version (NodeJS ssb pub)
- Add dnsmasq to WiFi and configure proxy for custom domains
