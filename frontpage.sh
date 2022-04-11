#!/bin/bash

PDFDENSITY=150
JPGQUALITY=75

todaystring=$(date '+%Y/%m/%d')
todayname=$(date '+%Y%m%d')
yesterstring=$(date -d "yesterday 13:00" '+%Y/%m/%d')
yestername=$(date -d "yesterday 13:00" '+%Y%m%d')

pathname=/home/pi/frontpage/
todaypdf="${pathname}${todayname}.pdf"
todayjpg="${pathname}${todayname}.jpg"
yesterpdf="${pathname}${yestername}.pdf"
yesterjpg="${pathname}${yestername}.jpg"

displayjpg="$todayjpg"

# if todays jpg already exists display that
if [ -f "$todayjpg" ]; then
  echo "$todayjpg exists"
else
  wget "https://static01.nyt.com/images/$todaystring/nytfrontpage/scan.pdf" -O "$todaypdf"
  if [ $? -ne 0 ]; then
    # does not exist, display yesterday's jpg
    # check if yesterdays jpg exists
    if [ -f "$yesterjpg" ]; then
      displayjpg="$yesterjpg"
      echo "defaulting $yesterjpg"
    else
      #get yesterdays pdf
      wget "https://static01.nyt.com/images/$yesterstring/nytfrontpage/scan.pdf" -O "$yesterpdf"
      convert -density $PDFDENSITY "$yesterpdf" -quality $JPGQUALITY "$yesterjpg"
      echo "retrieved $yesterjpg"
    fi
    displayjpg="$yesterjpg"
    echo "displaying $yesterjpg"
  else
    # was able to download today's nyt
    rm "$yesterjpg" "$yesterpdf"
    convert -density $PDFDENSITY "$todaypdf" -quality $JPGQUALITY "$todayjpg"
    echo "retrieved $todayjpg"
  fi
fi

pkill -9 feh
DISPLAY=:0.0 /usr/bin/feh -qYzF --zoom fill "$displayjpg"
