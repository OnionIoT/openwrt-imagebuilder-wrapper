#!/bin/bash

## download and unzip the image builder
OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"
URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"
ZIP="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-x86_64.tar.xz"
FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-x86_64"
NEWNAME="openwrt-imagebuilder-$OPENWRT_VERSION"

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
cat config/new-repositories.conf >> $NEWNAME/repositories.conf
