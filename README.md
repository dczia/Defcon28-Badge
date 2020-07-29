# DEFCON28-Badge
DCZia 2020 Defcon 28 Badge - PiBadge Mini

```
 ____  _ ____            _            __  __ _       _ 
|  _ \(_) __ )  __ _  __| | __ _  ___|  \/  (_)_ __ (_)
| |_) | |  _ \ / _` |/ _` |/ _` |/ _ \ |\/| | | '_ \| |
|  __/| | |_) | (_| | (_| | (_| |  __/ |  | | | | | | |
|_|   |_|____/ \__,_|\__,_|\__, |\___|_|  |_|_|_| |_|_|
                           |___/                       
```

## Description
This year was crazy, so our origianl plan never happened. Howerever we wanted to do something so that people could have a badge for this year. Our idea was to have an open source design that you can buy parts online and put together at home. We did this with our first badge, and decided to revisit it now just in a smaller package! 

DCZia would like to present the PiBadge Mini: A Raspberry Pi Zero W with a Waveshare 1.44" LCD Display. We wrote a custom image for the Pi that will auto play some open source and in house made videos. 

#### *Please Note this build guide is not complete - Come back 7/30 for final instructions but you can order hardware now!*

## Hardware

The General Hardware used for this is:
- Raspberry Pi Zero W
- Waveshare 1.44" Pi Zero LCD Screen
- SD Card

Optional unsupported but likely to work:
- Any Pi
- Any screen supported by https://github.com/juj/fbcp-ili9341 

## Mini Pi Badge Official Parts

* WaveShare 1.44" LCD Screen 128x128 Resolution
  * https://www.amazon.com/waveshare-1-44inch-Interface-Direct-pluggable-Raspberry/dp/B077Z7DWW1/ref=sr_1_3?dchild=1&keywords=waveshare%2B1.44&qid=1595712958&sr=8-3&th=1

* Raspberry Pi Zero w/header presoldered
  * https://www.amazon.com/gp/product/B07W3GJTM1/ref=ox_sc_act_title_1?smid=A3B0XDFTVR980O&psc=1

* Or if you can solder  
  * Pi Zero W kit with accessories
  * https://www.amazon.com/dp/B0748MPQT4?psc=1&pf_rd_p=0dd39e5f-9b69-4a93-972dfe359b592bc4&pf_rd_r=PXD8W6JGQPPXJ9604N51&pd_rd_wg=B8nLy&pd_rd_i=B0748MPQT4&pd_rd_w=Bfyr1&pd_rd_r=f901f48a-ab0e-4285-bbe7-2b7a721e479a&ref_=pd_luc_rh_crh_rh_sim_01_01_t_img_lh

* SD card 8GB minimun
  * https://www.amazon.com/Sandisk-Ultra-Micro-UHS-I-Adapter/dp/B073K14CVB/ref=sr_1_3?dchild=1&keywords=micro+sd+8&qid=1595713435&s=electronics&sr=1-3
  
## Software

### Official DCZia Raspbian / Debian Buster Image
  Coming soon!
  
### Build Script
Clone this repo and run the dczia_setup.sh script on a Raspbian Buster Light stock install. 

Still a work in progress. Curreently it supports our PiBadge 1/2 screen the Adafruti PiTFT 3.5", and the WaveShare 1.44" LCD. Shoudl work on a Pi Zero, Pi Zero W, Pi A, and Pi B.
  
## Alternative Options

### Bring your own pi or fbcp-ili9341 display
If you have any pi with a base Raspbian Buster image you should be able to run our setup script to build the badge environment. You will likely need to tune the fbcp-ili9341 build options for your screen. 

Also if you have any PiScreen you should also be able to install the native drivers for your screen and then remove the fbcp-ili9341 driver section from the script to get up and running, but this is unsupported and other drivers may have performance issues.

### PiBadge XL

What? I thought this year you were doing mini?! I know,.. I know... but if you want to go big we also present the PiBadge XL. Go buy a Hyperpixel 4" screen here:
https://www.pishop.us/product/non-touch-hyperpixel-4-0-hi-res-display-for-raspberry-pi/

Pi Shop also carries the Pi Zero W with and without headers: https://www.pishop.us/product/raspberry-pi-zero-w/

Hyperpixel Cases: https://www.thingiverse.com/search?q=Hyperpixel&type=things&sort=relevant&page=2

### Cases
Coming Soon!

## Troubleshooting

### Enable Wifi
If you want to configure your pi to have network access there are two way to do it:

*If you do not have a keyboard & monitor*
Mount your /boot partition on the SDCard and add a file called wpa_supplicant.conf

Add the following information:
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert 2 letter ISO 3166-1 country code here>

network={
 ssid="<Name of your wireless LAN>"
 psk="<Password for your wireless LAN>"
}
```
More info at: https://www.raspberrypi.org/documentation/configuration/wireless/headless.md

*If you have a keyboard and monitor*

Log into your Pi using the default Raspbian username and password then use the tool raspi-config to setup WiFi. 

Alternativly you can use the commandline to setup your wireless network.

Open the wpa-supplicant config file in nano or vi:

sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

Add the following lines to the bottom:
```
network={
    ssid="your network"
    psk="your password"
    }
```
NOTE: for added security (who doesn’t appreciate that?), omit the quotes and input your password as a 32 byte hexadecimal!

Save the file by pressing Ctrl+x, then y, then Enter

If it doesn’t work, check your inputs

More config deets available at https://www.raspberrypi.org/documentation/configuration/wireless
