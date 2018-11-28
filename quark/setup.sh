#!/bin/bash

quark_path="$HOME/.wine/drive_c/Program Files (x86)/QuArK 6.6"
if [ -d "$quark_path" ]; then
    ln -s "$PWD/duges.qrk" "$quark_path/duges.qrk"
else
    echo "ERROR: QuArK path not found: $quark_path"
fi


steam_hl_path="$HOME/.steam/steam/steamapps/common/Half-Life"
if [ -d "$steam_hl_path" ]; then
    if [ ! -e "Half-Life" ]; then
        ln -s "$steam_hl_path" "Half-Life"
    fi
    if [ ! -f "$steam_hl_path/HL.EXE" ]; then
	    touch "$steam_hl_path/HL.EXE"
    fi
    if [ ! -e "$steam_hl_path/cstrike/itsItaly.wad" ]; then
        ln -s "$steam_hl_path/cstrike/itsitaly.wad" "$steam_hl_path/cstrike/itsItaly.wad"
    fi
else
    echo "ERROR: Half-Life installation not found from path: $steam_hl_path"
fi

echo "If no errors, now set QuArK Half-Life path to Half-Life under this directory"
