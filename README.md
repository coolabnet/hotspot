# P2P Hotspot

P2P Hotspot is a low-energy device that creates an access-point serving p2p applications, bridges and content. Software stack and content are automatically updated while online, and can be updated offline by using usb storage devices.

A team can easily monitor and give direct support to all devices (with granted consent) while online. Device can be temporarly transported to a place with connectivity or connect to a mobile hotspot for receiving direct support.

## Getting started

We'll need Internet connection for downloading latest software and content. But after initial setup, device can exist and be updated offline.

*Needed hardware:*

- Computer: Raspberry ?
- Storage: class 10 micro sd with min 64Gb or SSD connected thru usb
- (if using SSD && acess-point) Wifi Dongle: a Wifi dongle compatible with our device
1. Click "[Deploy with Balena](https://www.balena.io/docs/learn/deploy/deploy-with-balena-button/)" button
2. Create free Balena account
3. Set community environmental variables (wifi acess point name, wifi password, device name on network, community name, language, content repository address, map-tiles links)
4. Download project image
5. Burn image to micro sd or usb SSD
6. Plug storage into computer
7. Plug computer to power supply
8. Connect to the Internet (ethernet cable or wifi connection)
9. Check Balena dashboard if device is online
10. Wait for device to update it's software on Balena dashboard
11. Wait for device to sync it's content through distributed file system
12. Your device is ready to go offline!

## Usage

*Needed hardware:* Computer with pre-loaded software and content from **Getting started** section
1. Plug computer to power supply
2. Search for WiFi hotspots
3. Connect to pre-configured Wifi name
4. Captive-portal with portal should pop-up
5. Follow guides and install tools on user devices

Using Manyverse:
1. Install application
2. Walk through app onboarding
3. Go to connections tab
4. Follow devices on local Wifi
5. Wait for initial synchronization
6. Follow friends and publish content!

Using F-Droid on Adroid:

1. Download F-Droid
2. Install F-Droid
3. Add local repository to F-Droid
4. Install or update curated applications



## Software stack

### Operating System

Meant to run on [Balena](https://balena.io), which runs easily composable service blocks on a performeant container-based operating system. Advantages:

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
- ssh tunnel & remote support

### Service Stack

- [ ] **Wifi**: creates a WiFi Access-Point with a Captive-portal redirecting user to portal application, [ref](https://github.com/balena-os/wifi-connect)
- [ ] **Browser**: exposes a kiosk browser pointed to portal application to output devices connected to hdmi [ref](https://github.com/balenablocks/browser)
- [ ] **Portal**: application which onboards new users and links to content and services (ND)
- [ ] **F-Droid**: repository of apks to be used with offline app installer F-Droid
- [ ] **Distributed File System**: automatically updates content if online through p2p sync (ND)
- [ ] **Installers**: track and download latest installers for apps and expose them through a simple GUI (ND) [ref](https://www.manyver.se/download/)
- [ ] **SSB-Pub**: SSB's distributed database. Pub connects automatically to a room outside the local network (on the Internet)
## Extending

- Support more simultaneous users and extend wifi range with a router
- Extend router's wifi range by setting up a mesh network with your neighbors