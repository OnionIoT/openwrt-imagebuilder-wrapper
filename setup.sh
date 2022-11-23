#!/bin/bash

cd $(dirname $0)

. ./profile

[ -z "$OPENWRT_VERSION" ] && exit 1

BUILD_DIR="$PWD/build/openwrt-$OPENWRT_VERSION"
mkdir -p "$BUILD_DIR"

TARGET_DIR="$BUILD_DIR/imagebuilder"
ZIP="$BUILD_DIR/${IMAGE_BUILDER_URL##*/}"
FILE="${ZIP//.tar.xz}"

download_imagebuilder() {
	[ -e $ZIP ] && return 0

    if ! curl "$IMAGE_BUILDER_URL" -o "$ZIP"; then
        echo "ERROR downloading image builder"
		return 1
    fi

	return 0
}

verify_imagebuilder() {
	if ! tar tJf "$ZIP" > /dev/null; then
		echo "ERROR: invalid archive $ZIP"
		return 1
	fi

	return 0
}

extract_imagebuilder() {
	if ! tar -C "$BUILD_DIR" -xJf "$ZIP"; then
		echo "ERROR: decompression failed for $ZIP"
		return 1
	fi
	
	[ -z "$TARGET_DIR" ] && return 1
	[ -d "$TARGET_DIR" ] && rm -rf "$TARGET_DIR"

	mv "$FILE" "$TARGET_DIR" || return 1

	return 0
}

update_package_repos() {
	## add the onion package repo to the feeds

	[ -z "$IPK_REPOS" ] && return 0

	echo -e "$IPK_REPOS" >> $TARGET_DIR/repositories.conf

	return 0
}

download_imagebuilder || exit 1
verify_imagebuilder || exit 1
extract_imagebuilder || exit 1
update_package_repos || exit 1
