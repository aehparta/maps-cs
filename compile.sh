#!/bin/bash

game_run="no"
mode=""

for arg in ${@:2}; do
	case $arg in
		run)
			game_run="yes"
			;;
		fast)
			mode="fast"
			;;
		final)
			mode="final"
			;;
		leaks)
			mode="leak"
			;;
	esac
done

# set to custom in $map/attributes.txt
ambient_r="0.0"
ambient_g="0.0"
ambient_b="0.0"

threads=4

game_path="$HOME/.steam/steam/steamapps/common/Half-Life"
repo_path=`pwd`
tools_path="$repo_path/zhlt-vluzacn/bin"

map="$1"

hlcsg_opt=""
hlbsp_opt=""
hlvis_opt=""
hlrad_opt=""

# load custom attributes
if [ -f "$map/attributes.txt" ]; then
	source "$map/attributes.txt"
fi

if [ "$mode" == "leak" ]; then
	hlbsp_opt="$hlbsp_opt -leakonly"
elif [ "$mode" == "fast" ]; then
	hlvis_opt="$hlvis_opt -fast"
	hlrad_opt="$hlrad_opt -fast"
else
	hlvis_opt="$hlvis_opt -full"
	hlrad_opt="$hlrad_opt -extra"
fi

map_file="maps/$map.map"
bsp_file="maps/$map.bsp"

lights_file="$repo_path/$map/lights.rad"
if [ ! -f "$lights_file" ]; then
	lights_file="$repo_path/lights.rad"
fi

cd "$game_path/tmpQuArK"

if [ "$map" == "" ]; then
	echo "usage: <map> [fast]"
	exit 1
elif [ ! -f "$map_file" ]; then
	echo "map_file file not found: $game_path/tmpQuArK/$map_file"
	exit 1
fi

if [ "$mode" != "" ]; then
	$tools_path/hlcsg -threads $threads -low -nowadtextures $hlcsg_opt "$map_file"
	if [ "$?" != "0" ]; then
		echo "ERROR: hlcsg failed"
		exit 1
	fi

	$tools_path/hlbsp -threads $threads -low $hlbsp_opt "$map_file"
	if [ "$?" != "0" ]; then
		echo "ERROR: hlbsp failed"
		exit 1
	fi
	if [ "$mode" == "leak" ]; then
		echo "LEAK CHECK OK"
		exit 0
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
fi

if [ -f "$bsp_file" ]; then
	cp "$bsp_file" "$repo_path/bsp/$map.bsp"
	mkdir -p "$game_path/cstrike_downloads/maps"
	cp "$bsp_file" "$game_path/cstrike_downloads/$bsp_file"
	if [ "$game_run" == "yes" ]; then
		steam -applaunch 10 -console +sv_lan 1 +set sv_cheats 1 +map "$map"
	fi
else
	echo "ERROR: bsp file does not exists: $bsp_file"
	exit 1
fi

exit 0
