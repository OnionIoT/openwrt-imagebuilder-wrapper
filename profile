#!/bin/sh

# Stable OpenWrt Release version (Needs change whenever new openwrt release is available)
OPENWRT_RELEASE="23.05"
OPENWRT_VERSION="${OPENWRT_RELEASE}.3"
ARCH="mipsel_24kc"
TARGET="ramips"
SUBTARGET="mt76x8"

# Default base URL from where openwrt SDKs are available for the respective openwrt version and targets
# BASE_URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"
BASE_URL="http://downloads.onioniot.com.s3.amazonaws.com/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

# imagebuilder file name available and downloaded from BASE_URL ((Needs change whenever new openwrt release is available with different gcc version))
#IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-$(uname -m).tar.xz"
IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-x86_64.tar.xz"
IMAGE_BUILDER_URL="$BASE_URL/$IMAGE_BUILDER_FILE"

# Additions directory copy custom files into image builder dir
ADDITIONS_DIR="$PWD/additions"

## specify ipk repos to be included in the firmware (each repo in new line) 
PACKAGE_REPOS="
# Override openwrt_core repo with Onion Core repo
src/gz openwrt_core http://downloads.onioniot.com/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET/packages
src/gz onion_base http://downloads.onioniot.com/releases/$OPENWRT_VERSION/packages/$ARCH/base
src/gz onion_luci http://downloads.onioniot.com/releases/$OPENWRT_VERSION/packages/$ARCH/luci
src/gz onion_packages http://downloads.onioniot.com/releases/$OPENWRT_VERSION/packages/$ARCH/packages
src/gz onion_routing http://downloads.onioniot.com/releases/$OPENWRT_VERSION/packages/$ARCH/routing
src/gz onion_telephony http://downloads.onioniot.com/releases/$OPENWRT_VERSION/packages/$ARCH/telephony
src/gz onion_openwrt_packages http://repo.onioniot.com/omega2/packages/openwrt-$OPENWRT_VERSION/onion
src/gz onion_openwrt_core http://repo.onioniot.com/omega2/packages/openwrt-$OPENWRT_VERSION/core
"

# PACKAGE_REPOS="
# src/gz onion file:///home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/onion
# "

## specify packages to be included in the firmware (each package in new line)
IMAGE_BUILDER_PACKAGES="
onion-repo-keys
omega2-base
omega2-base-files
omega2-base-passwd
omega2-ctrl
i2c-tools
openssh-sftp-server
openssh-sftp-client
"

BUILD_MODELS="
onion_omega2
onion_omega2p
"
