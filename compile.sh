#!/bin/bash

# set to no in $map/attributes.txt to disable
game_run="yes"

# set to custom in $map/attributes.txt
ambient_r="0.0"
ambient_g="0.0"
ambient_b="0.0"

threads=4

game_path="$HOME/.steam/steam/steamapps/common/Half-Life"
repo_path=`pwd`
tools_path="$repo_path/zhlt-vluzacn/bin"

hlcsg_opt="-nowadtextures"
hlbsp_opt=""
hlvis_opt=""
hlrad_opt=""

if [ "$2" == "fast" ]; then
	hlvis_opt="$hlvis_opt -fast"
	hlrad_opt="$hlrad_opt -fast"
elif [ "$2" == "final" ]; then
	hlvis_opt="$hlvis_opt -full"
	hlrad_opt="$hlrad_opt -extra"
fi

map="$1"

# load custom attributes
if [ -f "$map/attributes.txt" ]; then
	source "$map/attributes.txt"
fi

map_file="maps/$map.map"
bsp_file="maps/$map.bsp"

lights_file="$repo_path/$map/lights.rad"
if [ ! -f "$lights_file" ]; then
	lights_file="$repo_path/lights.rad"
fi

cd "$game_path/tmpQuArK"

if [ "$map" == "" ]; then
	echo "usage: <map> [fast|final]"
	exit 1
elif [ ! -f "$map_file" ]; then
	echo "map_file file not found: $game_path/tmpQuArK/$map_file"
	exit 1
fi

$tools_path/hlcsg -threads $threads -low $hlcsg_opt "$map_file"
if [ "$?" != "0" ]; then
	echo "ERROR: hlcsg failed"
	exit 1
fi

$tools_path/hlbsp -threads $threads -low $hlbsp_opt "$map_file"
if [ "$?" != "0" ]; then
	echo "ERROR: hlbsp failed"
	exit 1
fi

$tools_path/hlvis -threads $threads -low $hlvis_opt "$map_file"
if [ "$?" != "0" ]; then
	echo "ERROR: hlvis failed"
	exit 1
fi

$tools_path/hlrad -threads $threads -low -lights "$lights_file" -ambient "$ambient_r" "$ambient_g" "$ambient_b" $hlrad_opt "$map_file"
if [ "$?" != "0" ]; then
	echo "ERROR: hlrad failed"
	exit 1
fi

echo "COMPILE OK"

if [ -f "$bsp_file" ]; then
	if [ "$game_run" == "yes" ]; then
		mkdir -p "$game_path/cstrike_downloads/maps"
		cp "$bsp_file" "$game_path/cstrike_downloads/$bsp_file"
		steam -applaunch 10 -console +sv_lan 1 +set sv_cheats 1 +map "$map"
	fi
else
	echo "ERROR: bsp file does not exists: $bsp_file"
	exit 1
fi

exit 0
