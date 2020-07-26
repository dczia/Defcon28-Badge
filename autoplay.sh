#!/usr/bin/env bash


#Sets the playlist to play:
$TEST
# $DEFAULT 
# $MOVIES
# $C64

##Turns off cursor blink on display
# setterm -cursor off > /dev/tty0

##Clear the term before firing up omxplayer
# clear > /dev/tty0

if [ -v "${TEST}" ]
then
 omxplayer --loop --fps 24 --no-osd -z -b --no-keys --aspect-mode stretch /home/pi/Defcon28-Badge/videos/exhaust_test.mp4 > /dev/null 2>&1 &

elif [ -v "${DEFAULT}" ]
then
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

elif [ -v "${MOVIES}" ]
then
  echo "Movies"
  omxplayer --loop --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC_Movie.mp4 &

elif [ -v "${C64}" ]
then
  echo "C64"
  omxplayer --loop --fps 24 --no-osd -z --aspect-mode stretch /home/pi/Defcon28-Badge/videos/DC64.mp4 &

fi

