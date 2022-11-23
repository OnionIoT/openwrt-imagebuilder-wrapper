#!/bin/sh

OPENWRT_VERSION="22.03.2"
TARGET="ramips"
SUBTARGET="mt76x8"

BASE_URL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET"

IMAGE_BUILDER_FILE="openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-x86_64.tar.xz"
IMAGE_BUILDER_URL="$BASE_URL/$IMAGE_BUILDER_FILE"

SDK_FILE="openwrt-sdk-$OPENWRT_VERSION-$TARGET-${SUBTARGET}_gcc-11.2.0_musl.Linux-x86_64.tar.xz"
SDK_URL="$BASE_URL/$SDK_FILE"

## specify ipk repos to be included in the firmware (each repo in new line) 
IPK_REPOS="
src/gz onion http://repo.onioniot.com/omega2/packages/openwrt-22.03.2/onion
"

## specify packages to be included in the firmware (each package in new line)
PACKAGES="
onion-repo-keys
omega2-base
omega2-base-files
omega2-base-passwd
"
