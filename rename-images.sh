#!/bin/sh

### rename firmware images based on device name and version number


DIR="openwrt-imagebuilder/bin/targets/ramips/mt76x8"

## find version and build number
# get repo location
PKG_URL=$(cat config/new-repositories.conf | sed -e 's/.*http/http/' -e 's/$/\/Packages/')
# grab package info file, find version number of omega2-base package, format properly
VERSION_INFO=$(wget -q -O - $PKG_URL | grep -A1 "Package: omega2-base$" | grep Version | sed -e 's/Version: //' -e 's/^/v/' -e 's/-/-b/')


renameImage () {
    device="$1"
    echo "Renaming image for $device device"
    if [ ! -d output ]; then
        mkdir output
    fi

    imageName="${device}-${VERSION_INFO}.bin"
    cp $DIR/openwrt-21.02.1-ramips-mt76x8-${device}-squashfs-sysupgrade.bin output/$imageName
}

# rename images
renameImage "onion_omega2"
renameImage "onion_omega2p"