#!/bin/bash

OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"
DIR="openwrt-imagebuilder-$OPENWRT_VERSION"

## update the image builder
# copy over required files
cp -r additions/* ${DIR}/

## specify packages to be included in the firmware (space separated list)
packages="onion-repo-keys omega2-base omega2-base-files omega2-base-passwd"

## run the image builder
cd ${DIR}/
bash build.sh "$packages"
retval=$?

echo " "
if [ $retval -eq 0 ]; then
    echo "> Compiled firmware at ${DIR}/bin/targets/$TARGET/$SUBTARGET/"
else
    echo "> Compilation error!"
fi
