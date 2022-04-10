#!/bin/bash

todaystring=$(date '+%Y/%m/%d')
todayname=$(date '+%Y%m%d')
yesterstring=$(date -d "yesterday 13:00" '+%Y/%m/%d')
yestername=$(date -d "yesterday 13:00" '+%Y%m%d')

pathname=/home/pi/Documents/Frontpage/
todaypdf="${pathname}${todayname}.pdf"
todayjpg="${pathname}${todayname}.jpg"
yesterpdf="${pathname}${yestername}.pdf"
yesterjpg="${pathname}${yestername}.jpg"

displayjpg="$todayjpg"

wget "https://static01.nyt.com/images/$todaystring/nytfrontpage/scan.pdf" -O "$todaypdf"
if [ $? -ne 0 ]; then
  # does not exist, display yesterday's jpg
  displayjpg="$yesterjpg"
  echo "displaying $yesterjpg"
else
  # if todays jpg already exists display that
  if [ -f "$todayjpg" ]; then
    echo "$todayjpg exists"
  else
    rm "$yesterjpg" "$yesterpdf"
    convert -density 150 "$todaypdf" -quality 50 "$todayjpg"
  fi
fi

pkill -9 feh
DISPLAY=:0.0 /usr/bin/feh -qYzF --zoom fill "$displayjpg"
