# Image Builder Profile Configuration

Image Builder profiles are managed in profiles directory. Any profile file can be copied to the repo root directory with `profile` file.

i.e

`profiles/default` is default profile template configuration. To use `default` profiles template.

`cp profiles/default profile`

## Environment Variables

profile file has predefined env variables which are being used in `onion_buildenv` script to manage all its actions.

|Variable|Default Value|Description|
|--------|-------------|-----------|
|`OPENWRT_VERSION`|`22.03.2`|OpenWrt Release Version|
|`TARGET`|`ramips`|SDK to compile packages for target|
|`SUBTARGET`|`mt76x8`|SDK to compile packages for subtarget|
|`BASE_URL`|`https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET`|Root URL of SDK for specificed target and subtarget|
|`IMAGE_BUILDER_FILE`|`openwrt-imagebuilder-$OPENWRT_VERSION-$TARGET-$SUBTARGET.Linux-$(uname -p).tar.xz`|Image Builder file to be downloaded from `BASE_URL`|
|`IMAGE_BUILDER_URL`|`$BASE_URL/$SDK_FILE`|Full Image Builder download URL|
|`ADDITIONS_DIR`|`$PWD/additions`|Location of addinational files to be copied into imagebuilder dir|
|`PACKAGE_REPOS`|`src/gz onion http://repo.onioniot.com/omega2/packages/openwrt-$OPENWRT_VERSION/onion`|Appends lines to `repositories.conf` in the downloaded OpenWRT Image Builder.<br/>Each feed must be in a new line
|`IMAGE_BUILDER_PACKAGES`|`onion-repo-keys`</br>`omega2-base`<br/>`omega2-base-files`<br/>`omega2-base-passwd`|Packages to be included in firmware. Each package must be in a new line|
|`BUILD_MODELS`|`onion_omega2`</br>`onion_omega2p`|Onion Models firmware to be compiled when `onion_buildenv build_all_firmwares` is triggered. Each model must be in a new line|

## Onion Image Builder Build Environment

profile file is used with `onion_buildenv` script. `onion_buildenv` is all in one script that makes build process simple and customization can be done in profile file only.
`onion_buildenv` provides few subcommands that can be used to setup sdk and compile packages.

|subcommand|Description|
|----------|-----------|
|`setup_imagebuilder`|Download and setup imagebuilder with files, keys and packages|
|`update_imagebuilder`|Update repositories into imagebuilder|
|`clean_imagebuilder`|Cleanup image builder from local directory|
|`list_packages`|List all available packages, Internally it uses `./scripts/feeds list`|
|`build_firmware <model>`|Build firmware for model passed in argument|
|`build_all_firmwares`|Build firmware for all the models specified in var `BUILD_MODELS`|

## Use custom feed for local/alternative development

During development, there might be a need to pull compiled packages from a local source.

In that case, change the value of `PACKAGE_REPOS`

```
PACKAGE_REPOSE="
src-link custom <FEED-DIRECTORY-HERE>
"
```

And run the `bash onion_buildenv setup_imagebuilder` script again.
