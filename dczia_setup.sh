#!/bin/bash

####################################################
##
##  ___   ___ _____
## |   \ / __|_  (_)__ _
## | |) | (__ / /| / _` |
## |___/ \___/___|_\__,_|
##
## DCZia 2020 PiBadge Mini Build Scrip
## @lithochasm & @toasty
##
##
##
##
##
##
##
##
####################################################


###############################
#### Get Command Line Options
###############################
while getopts ":a" opt; do
  case $opt in
    a)
      echo "-a was triggered!" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


###############################
#### Setup
###############################
clear
echo "DCzia Badge Setup v1"

###############################
#### Check if we have internet
###############################
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo Net Connection Detected! || echo Error Cannont Connect to Net T_T


###############################
#### Install base packages
###############################
echo "Installing Software\n"

sudo apt-get install omxplayer cmake libbsd-dev vim git
git clone https://github.com/juj/fbcp-ili9341.git
git clone https://github.com/dczia/Defcon28-Badge.git

###############################
#### Setup Video
###############################




#########################################
#### So Long And Thanks For All The Fish!
printf -- '\n';
exit 0;
