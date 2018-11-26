#!/bin/bash

ambient_r="0.001"
ambient_g="0.001"
ambient_b="0.002"

repo_path=`pwd`
tools_path="$repo_path/zhlt-vluzacn/bin"
lights_file="$repo_path/lights.rad"

hlcsg_opt="-nowadtextures"
hlbsp_opt=""
hlvis_opt=""
hlrad_opt=""

if [ "$2" == "fast" ]; then
	hlvis_opt="$hlvis_opt -fast"
	hlrad_opt="$hlrad_opt -fast"
else
	hlvis_opt="$hlvis_opt -full"
	hlrad_opt="$hlrad_opt -extra"
fi

threads=4
game_path="$HOME/Documents/Half-Life"

map="$1"
map_file="maps/$map.map"

cd "$game_path/tmpQuArK"

if [ ! -f "$map_file" ]; then
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

cd ..

# wine hl.exe -console -dev -zone 1024 +set sv_cheats 1 -game tmpQuArK +map "$1"
