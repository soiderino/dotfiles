#!/bin/sh

status=$(playerctl --player=spotify status 2>/dev/null)

if [ "$status" = "Playing" ]; then
  icon=""
elif [ "$status" = "Paused" ]; then
  icon=""
else
  echo ""
  exit 0
fi

artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
title=$(playerctl --player=spotify metadata title 2>/dev/null)


echo "$icon $artist - $title"
