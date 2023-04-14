#!/bin/sh

# Stable OpenWrt Release version (Needs change whenever new openwrt release is available)
OPENWRT_VERSION="22.03.3"
TARGET="ramips"
SUBTARGET="mt76x8"

# Default base URL from where openwrt SDKs are available for the respective openwrt version and targets
BASE_URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

# imagebuilder file name available and downloaded from BASE_URL ((Needs change whenever new openwrt release is available with different gcc version))
IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-$(uname -p).tar.xz"
IMAGE_BUILDER_URL="$BASE_URL/$IMAGE_BUILDER_FILE"

# Additions directory copy custom files into image builder dir
ADDITIONS_DIR="$PWD/additions"

## specify ipk repos to be included in the firmware (each repo in new line) 
PACKAGE_REPOS="
src/gz onion http://repo.onioniot.com/omega2/packages/openwrt-$OPENWRT_VERSION/onion
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
"

BUILD_MODELS="
onion_omega2
onion_omega2p
"
