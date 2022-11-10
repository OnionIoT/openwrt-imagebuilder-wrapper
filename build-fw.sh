#!/bin/bash

DIR="openwrt-imagebuilder"

## update the image builder
# copy over required files
cp -r additions/* ${DIR}/

## specify which packages should be included in the firmware (space separated list)
# none for now
packages=""

## run the image builder
cd ${DIR}/
bash build.sh "$packages"
retval=$?

echo " "
if [ $retval -eq 0 ]; then
    echo "> Compiled firmware at ${DIR}/bin/targets/ramips/mt76x8/"
else
    echo "> Compilation error!"
fi
