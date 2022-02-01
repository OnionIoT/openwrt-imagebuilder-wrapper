#!/bin/sh

### rename firmware images based on device name and version number


DIR="openwrt-imagebuilder/bin/targets/ramips/mt76x8/"

# find version and build number
VERSION=$(cat additions/files/etc/uci-defaults/12_onion_defaults | grep "onion.version" | sed -re "s/^.+='//" -e "s/'.*$//")
BUILD=$(cat additions/files/etc/uci-defaults/12_onion_defaults | grep "onion.build" | sed -re "s/^.+='//" -e "s/'.*$//")


renameImage () {
    device="$1"
    echo "Renaming image for $device device"
    if [ ! -d output ]; then
        mkdir output
    fi

    imageName="${device}-v${VERSION}-b${BUILD}.bin"
    cp $DIR/openwrt-21.02.1-ramips-mt76x8-${device}-squashfs-sysupgrade.bin output/$imageName
}

# rename images
renameImage "onion_omega2"
renameImage "onion_omega2p"