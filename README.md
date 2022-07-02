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
- Internet connection through ethernet cable

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
1. Set environment variables (or use defaults)

| Env var | Description | Default |
| ------------- | ------------- | ------------- |
| AP_SSID | Access point network name. | `WiFi Repeater` |
| AP_PASSWORD | Access point network password. | `none` |
| WIFI_SSID | WiFi network name | |
| WIFI_PASSWORD | WiFi network password | |
| PUB_NAME | The SSB's pub name | `P2P Hotspot` |
| ROOM | Room address where the pub will connnect | `room.coolab.org:8008~shs:foHx1HuvaN++iCrQS+Zi916V6iNYEOtj9ZOAo+a0E+Q=` |
| PUB | Pub address where the pub will connect | `pub.freesocial.co:8008~shs:ofYKOy2p9wsaxV73GqgOyh6C6nRGFM5FyciQyxwBd6A=` |


## Usage

1. On a phone or computer search for WiFi access point and connect
1. Captive-portal with portal should pop-up, if not go to [10.42.0.1:8081](http://10.42.0.1:8081)
1. Follow guides and install tools on user devices

## Connectivity
![WiFi Repeater modes of operation](https://github.com/balenalabs/wifi-repeater/raw/master/img/modes.png)

*Uses [wifi-repeater](https://github.com/balenalabs/wifi-repeater)*

Device will automatically scan your network and check each device's capabilities. It will then attempt to configure the devices to work in `Access Point` mode and if that is not possible it will switch to `Repeater` mode. You *do not* need to pre configure the device to work in either mode.

For `Access Point` mode it needs:
- Internet connectivity via Ethernet
- Wireless device with AP capabilities (such as the onboard WiFi chip in Raspberry Pi devices)

For `Repeater` mode it needs:
- Wireless device with AP capabilities (such as the onboard WiFi chip in Raspberry Pi devices)
- Secondary wireless device and valid credentials for a wireless network.

In case you have no access to an ethernet cable connecting to the routing device, WiFi connection can be set directly inside the SD card by following [this guide](https://www.balena.io/docs/reference/OS/network/#wifi-setup).
### LED patterns

In case something goes wrong WiFi repeater will produce a series of blinking patterns with the ACT LED (next to PWR LED) to help troubleshoot the issue.
Valid patterns are the following:

| LED pattern | Problem | Description | Solution (AP mode) | Solution (Repeater mode) |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| 2 blinks | Could not find a wireless device with Access Point capabilities | Wireless devices detected don't support Access Point mode. | Use a WiFi chipset that supports AP mode or a WiFi dongle. | Use a WiFi chipset that supports AP mode or a WiFi dongle. |
| 3 blinks | Could not find a secondary wireless device | Ethernet is disconnected or has no internet access. Switched to repeater mode but could not find a secondary wireless device. | Provide internet access via Ethernet cable. | Provide a secondary wireless device by using a WiFi dongle. |
| 4 blinks | WiFi credentials for secondary wireless device not provided. | Ethernet is disconnected or has no internet access. Switched to repeater mode but could not find WiFi credentials. | Provide internet access via Ethernet cable. | Provide valid WiFi credentials |
| 5 blinks | No internet access | Ethernet is disconnected or has no internet access. Switched to repeater mode, connected to WiFi but still have no internet access. | Provide internet access via Ethernet cable. | Ensure the target WiFi has internet access. |
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
- Check for portal and installer updates before attempting to download them
- Have Internet block work
- Optionally password protect Internet access
- Add p2p installer and browser applications ([Dat Installer](https://github.com/staltz/dat-installer) and [Agregore Browser](https://agregore.mauve.moe/) for example)
- Run an [F-Droid repository](https://gitlab.com/fdroid/wiki/-/wikis/List-of-F-Droid-repositories)
- Add service that scrapes latest apks and installers and serves them as F-droid and Dat-Installer repositories
- Have the pub publish an about photo
- Integrate [Peach Cloud](http://peachcloud.org/)
- Create an ARM32 version (NodeJS ssb pub)
- Add dnsmasq to WiFi and configure proxy for custom domains
