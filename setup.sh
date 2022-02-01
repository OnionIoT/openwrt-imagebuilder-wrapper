#!/bin/bash

## download and unzip the image builder
URL="https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt76x8"
ZIP="openwrt-imagebuilder-21.02.1-ramips-mt76x8.Linux-x86_64.tar.xz"
FILE="openwrt-imagebuilder-21.02.1-ramips-mt76x8.Linux-x86_64"
NEWNAME="openwrt-imagebuilder"

# remove previously configured image builder
rm -rf $NEWNAME

if [ ! -e ./$ZIP ]; then
    curl $URL/$ZIP -O
    retval=$?
    if [ $retval -ne 0 ]; then
        echo "ERROR downloading image builder"
        exit 1
    fi
fi

tar -xf $ZIP
mv $FILE $NEWNAME

## add the onion package repo to the feeds
cat add-repositories.conf >> $NEWNAME/repositories.conf