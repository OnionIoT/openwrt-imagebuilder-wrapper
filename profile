#!/bin/sh

# Stable OpenWrt Release version (Needs change whenever new openwrt release is available)
OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"

# Default base URL from where openwrt SDKs are available for the respective openwrt version and targets
BASE_URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

# imagebuilder file name available and downloaded from BASE_URL ((Needs change whenever new openwrt release is available with different gcc version))
IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-$(uname -p).tar.xz"
IMAGE_BUILDER_URL="$BASE_URL/$IMAGE_BUILDER_FILE"

# Files directory copy custom files into firmware image
FILES_DIR="$PWD/files"
KEYS_DIR="$PWD/keys"

## specify ipk repos to be included in the firmware (each repo in new line) 
PACKAGE_REPOS="
src/gz onion file://$PWD/../openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/onion/
"

## specify packages to be included in the firmware (each package in new line)
IMAGE_BUILDER_PACKAGES="
onion-repo-keys
omega2-base
omega2-base-files
omega2-base-passwd
"
