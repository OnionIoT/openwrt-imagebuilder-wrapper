#!/bin/bash

OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"
DIR="openwrt-imagebuilder-$OPENWRT_VERSION"

## update the image builder
# copy over required files
cp -r additions/* ${DIR}/

## specify which packages should be included in the firmware (space separated list)
# none for now
omega_packages="omega2-base omega2-base-files omega2-base-passwd"
openwrt_packages="uhttpd luci-base luci-mod-admin-full luci-mod-network luci-mod-status luci-mod-system luci-app-firewall luci-theme-bootstrap"

packages="$omega_packages $openwrt_packages"

## run the image builder
cd ${DIR}/
bash -x build.sh "$packages"
retval=$?

echo " "
if [ $retval -eq 0 ]; then
    echo "> Compiled firmware at ${DIR}/bin/targets/$TARGET/$SUBTARGET/"
else
    echo "> Compilation error!"
fi
