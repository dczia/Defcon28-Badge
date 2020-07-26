#!/bin/bash

####################################################
##
##  ___   ___ _____
## |   \ / __|_  (_)__ _
## | |) | (__ / /| / _` |
## |___/ \___/___|_\__,_|
##
## DCZia 2020 PiBadge Mini Build Scrip
## 
## Script by @lithochasm & @toasty
## Shoutout to the DCZia Crew
##
##
##
##
####################################################


###############################
#### Get Command Line Options
###############################
while getopts ":d::h" opt; do
case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument. Please specify display type" >&2
      exit 1
      ;;
    h)
      echo "Halp: -d DISPLAY_VAR " >&2
      exit 1
      ;;
  esac
done


###############################
#### Setup
###############################
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
white=$'\e[0m'


clear
echo " $blu"
echo "  ___   ___ _____"
echo " |   \\ / __|_  (_)__ _"
echo " | |) | (__ / /| / _\` | "
echo " |___/ \\___/___|_\\__,_| "
echo " $red DCzia Badge Setup v1 $white"
echo ""

###############################
#### Check if we have internet
###############################
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo $grn Net Connection Detected! $white || echo $red Error Cannont Connect to Net T_T $white


###############################
#### Install base packages
###############################
echo "$grn Installing Software $white"
echo ""

sudo apt-get install omxplayer cmake libbsd-dev vim git
git clone https://github.com/juj/fbcp-ili9341.git
echo ""

###############################
#### Setup TFT Screen Drivers
###############################
### NEED TO CHECK CMD LINE OPTION AND FORK HERE FOR EACH SCREEN TYPE
### Adafruit PiTFT 3.5
echo "$red Installing fbcp-ili9341 Driver $white"
cd fbcp-ili9341
mkdir build
cd build
cmake -DADAFRUIT_HX8357D_PITFT=ON -DDISPLAY_ROTATE_180_DEGREES=ON -DSTATISTICS=0 -DSPI_BUS_CLOCK_DIVISOR=6 ..
make -j
echo ""

###############################
#### System Setup Stuff
###############################
echo "$grn Checking /etc/rc.local $white"
if ! grep -q fbcp-ili9341 /etc/rc.local; then
	 echo "$red Updating rc.local - Enabling fbcp-ili9341 $white"
	 sudo sed -i -e '$asudo /home/pi/Defcon28-Badge/fbcp-ili9341/build/fbcp-ili9341 &' /etc/rc.local

 else
	 echo "$blu fbcp-ili9341 driver already enabled $white"
fi

if ! grep -q autoplay /etc/rc.local; then
         echo "$red Updating rc.local - Enabling Autoplay $white"
         sudo sed -i -e '$a /home/pi/Defcon28-Badge/autoplay.sh' /etc/rc.local
 else 
	 echo "$blu Autoplay already enabled $white"
fi
echo ""

echo "$grn Checking for Turbo Mode $white"
if ! grep -q force_turbo=1 /boot/config.txt; then
	         echo "$red Updating /boot/config.txt- Enabling Turbo $white"
		          sudo sed -i -e '$aforce_turbo=1' /boot/config.txt
		  else
			  echo "$blu Turbo mode already enabled $white"
fi
echo ""

#########################################
#### So Long And Thanks For All The Fish!
printf -- '\n';
exit 0;
