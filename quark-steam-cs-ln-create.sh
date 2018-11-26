#!/bin/bash

ln -s "$HOME/.steam/steam/steamapps/common/Half-Life"

if [ ! -f "Half-Life/HL.EXE" ]; then
	touch "Half-Life/HL.EXE"
fi
