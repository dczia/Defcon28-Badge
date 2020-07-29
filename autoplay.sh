#!/usr/bin/env bash

PLAYLIST="${1}"

#Sets the playlist to play:
# TEST (default)
# DEFAULT 
# MOVIES
# C64

##Turns off cursor blink on display
 setterm -cursor off > /dev/tty1

##Clear the term before firing up omxplayer
clear > /dev/tty1

if [[ -z "${PLAYLIST}" || "${PLAYLIST}" == "TEST" ]] ; then
  omxplayer --loop --no-osd -z -b --no-keys --aspect-mode stretch /home/pi/Defcon28-Badge/videos/exhaust_test.mp4 > /dev/null 2>&1 &

elif [[ "${PLAYLIST}" == "DEFAULT" ]] ; then
  echo "Default Playlist"
  ## Play some videos
  while true; do
  clear > /dev/tty0
  omxplayer --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/default.mp4
  clear > /dev/tty0
  omxplayer --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC_Movie.mp4
  clear > /dev/tty0
  omxplayer --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC64.mp4
  clear > /dev/tty0
  done
  # setterm -cursor on > /dev/tty0

elif [[ "${PLAYLIST}" == "MOVIES" ]] ; then
  echo "Movies"
  omxplayer --loop --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC_Movie.mp4 &

elif [[ "${PLAYLIST}" == "C64" ]] ; then
  echo "C64"
  omxplayer --loop --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC64.mp4 &

elif [[ "${PLAYLIST}" == "ALL" ]] ; then
  echo "ALL"
  clear > /dev/tty1
  for a in /home/pi/Defcon28-Badge/videos/* ; do omxplayer --no-osd -z -b --no-keys --aspect-mode stretch $a > /dev/null 2>&1 ; clear > /dev/tty1 ; done
fi

