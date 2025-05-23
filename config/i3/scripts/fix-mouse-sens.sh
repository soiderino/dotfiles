#!/bin/sh

speed=-0.8

for id in 11 26; do
    if xinput list | grep -q "id=$id\b"; then
      xinput set-prop $id 311 $speed
    fi
done

exit 0
