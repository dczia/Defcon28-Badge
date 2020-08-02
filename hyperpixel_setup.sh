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
while getopts "dhD:" opt; do
case $opt in
    d) # debug
      shopt -o -s xtrace
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
      echo "Halp:" >&2
      echo "Currently supported: Hyperpixel Display " >&2
      exit 1
      ;;
  esac
done

# default case if no options
if (( OPTIND == 1 )); then
   echo "Default option"
   DISPVAR="WAVESHARE"
fi

###############################
#### Setup
###############################
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
# mag=$'\e[1;35m'
# cyn=$'\e[1;36m'
white=$'\e[0m'


clear
echo " $blu"
echo "  ___   ___ _____"
echo " |   \\ / __|_  (_)__ _"
echo " | |) | (__ / /| / _\` | "
echo " |___/ \\___/___|_\\__,_| "
echo " $red DCzia Badge Setup v1 $white"
echo ""

echo "$red Please install the hyperpixel display drivers first!"
echo "curl https://get.pimoroni.com/hyperpixel4 | bash $white"
###############################
#### Check if we have internet
###############################
ping -q -w 1 -c 1 "$(ip r | grep default | cut -d ' ' -f 3)" > /dev/null && echo "$grn Net Connection Detected! $white" || echo "$red Error Cannont Connect to Net T_T $white"


###############################
#### Install base packages
###############################
echo "$grn Installing Software $white"
echo ""

sudo apt-get -y update
#sudo apt-get upgrade
sudo apt-get -y install omxplayer cmake vim git git-lfs chocolate-doom
wget --no-check-certificate http://www.doomworld.com/3ddownloads/ports/shareware_doom_iwad.zip
unzip shareware_doom_iwad.zip
wget https://dczia.s3-us-west-2.amazonaws.com/dczia2020.m4v
mv dczia2020.m4v videos
wget https://dczia.s3-us-west-2.amazonaws.com/L00t.7z
mv L00t.7z extras
echo ""


###############################
#### System Setup Stuff
###############################
echo "$grn Checking /etc/rc.local $white"
if ! grep -q autoplay /etc/rc.local; then
	 echo "$red Updating rc.local $white"
	 sudo sed -i 's/exit 0//g' /etc/rc.local

fi

if ! grep -q autoplay /etc/rc.local; then
         echo "$red Updating rc.local - Enabling Autoplay $white"
         sudo sed -i -e '$a sudo /home/pi/Defcon28-Badge/autoplay.sh DCZIA' /etc/rc.local
	 sudo sed -i -e '$a exit 0' /etc/rc.local
 else 
	 echo "$blu Autoplay already enabled $white"
fi
echo ""

echo "$grn Checking for DCZia Boot Settings $white"
if ! grep -q "DCZia_Hackz" /boot/config.txt; then
        echo "$red Updating /boot/config.txt - Enabling Speed Hacks $white"
        #cat /home/pi/Defcon28-Badge/boot_hacks | sudo tee -a /boot/config.txt > /dev/null
	sudo sed -i -e '$a gpu_mem=64' /boot/config.txt
	sudo sed -i -e '$a disable_overscan=1' /boot/config.txt
	sudo sed -i -e '$a hdmi_force_hotplug=1' /boot/config.txt
	sudo sed -i -e '$a hdmi_drive=2' /boot/config.txt
	sudo sed -i -e '$a hdmi_group=1' /boot/config.txt
	sudo sed -i -e '$a hdmi_mode=16' /boot/config.txt
	sudo sed -i -e '$a disable_splash=1' /boot/config.txt
	sudo sed -i -e '$a dtoverlay=sdtweak,overclock_50=84' /boot/config.txt
	sudo sed -i -e '$a boot_delay=0' /boot/config.txt
	sudo sed -i -e '$a force_turbo=1' /boot/config.txt
	#sudo systemctl disable triggerhappy.service
	sudo systemctl disable dphys-swapfile.service
	#sudo systemctl disable keyboard-setup.service
	#sudo systemctl disable apt-daily.service
	#sudo systemctl disable wifi-country.service
	#sudo systemctl disable hciuart.service
	#sudo systemctl disable raspi-config.service
	#sudo systemctl disable avahi-daemon.service
        #sudo systemctl disable rsyslog.service
else
	echo "$blu DCZIa Speed Hacks Enabled $white" 
fi

if ! grep -q "quiet" /boot/cmdline.txt; then

	echo "$red Setting up console $white"
	sudo sed -i -e '/console/ s/$/ quiet loglevel=3 /' /boot/cmdline.txt
fi

echo ""

#########################################
#### Sets new hostname
#########################################
host_name=pibadgemini
sudo echo $host_name | sudo tee /etc/hostname
sudo sed -i -E 's/^127.0.1.1.*/127.0.1.1\t'"$host_name"'/' /etc/hosts
#hostnamectl set-hostname $host_name

#########################################
#### Change Password
#########################################
echo -e "raspberry\ndczia2020\ndczia2020" | passwd pi


###############################
#### Setup TFT Screen Drivers
###############################

#curl https://get.pimoroni.com/hyperpixel4 | bash
echo ""

#########################################
#### So Long And Thanks For All The Fish!
#########################################
printf -- '\n';
exit 0;
