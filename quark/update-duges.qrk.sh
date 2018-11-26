#!/bin/bash

quark_path="/home/aehparta/.wine/drive_c/Program Files (x86)/QuArK 6.6"
if [ -f "$quark_path/duges.qrk" ]; then
    cp -a "$quark_path/duges.qrk" "duges.qrk"
fi

