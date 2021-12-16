#!/bin/sh

# this directory is a symlink on my machine:
KEYS_DIR=/sys/class/backlight/intel_backlight

test -d $KEYS_DIR || exit 0

MIN=0
MAX=$(cat $KEYS_DIR/max_brightness)
VAL=$(cat $KEYS_DIR/brightness)

if [ "$1" = down ]; then
	VAL=$((VAL-200))
else
	VAL=$((VAL+200))
fi

if [ "$VAL" -lt $MIN ]; then
	VAL=$MIN
elif [ "$VAL" -gt $MAX ]; then
	VAL=$MAX
fi

echo $VAL > $KEYS_DIR/brightness
