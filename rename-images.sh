#!/bin/sh

### rename firmware images based on device name and version number

OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"

DIR="openwrt-imagebuilder-$OPENWRT_VERSION/bin/targets/$TARGET/$SUBTARGET"

# Disabling this method for now
# ## find version and build number
# # get repo location
# PKG_URL=$(cat config/new-repositories.conf | sed -e 's/.*http/http/' -e 's/$/\/Packages/')
# # grab package info file, find version number of omega2-base package, format properly
# VERSION_INFO=$(wget -q -O - $PKG_URL | grep -A1 "Package: omega2-base$" | grep Version | sed -e 's/Version: //' -e 's/^/v/' -e 's/-/-b/')

DATE=$(date +"%Y%m%d")
VERSION_INFO="${OPENWRT_VERSION}-${DATE}"

renameImage () {
    device="$1"
    echo "Renaming image for $device device"
    if [ ! -d output ]; then
        mkdir output
    fi

    imageName="${device}-${VERSION_INFO}.bin"
    cp $DIR/openwrt-${OPENWRT_VERSION}-${TARGET}-${SUBTARGET}-${device}-squashfs-sysupgrade.bin output/$imageName
}

# rename images
renameImage "onion_omega2"
renameImage "onion_omega2p"