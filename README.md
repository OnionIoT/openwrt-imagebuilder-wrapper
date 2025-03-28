# OpenWRT Imagebuilder Wrapper

Tools to build OpenWRT firwmare for the Omega2 and Omega2+ using the [OpenWRT Image Builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder) in an easily repeatable and maintainable way.

## System Requirements

We recommend using **Ubuntu 22.04** Linux to build this repo. See the [OpenWRT Build System Setup instructions](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu) for details on what packages are required.

# How to Use this Repo

> By default, this repo is setup to build OpenWRT firmware for the Onion Omega2 and Omega2+

1. Run `bash onion_buildenv setup_imagebuilder` to download and setup the image builder
2. Run `bash onion_buildenv build_all_firmware` to build the Omega2 and Omega2+ firmware
3. Find the compiled firmware in the `output` directory

## Details

The `bash onion_buildenv setup_imagebuilder` script:

- Will download and setup the OpenWRT image builder
- Add the package repo specified as env variable `PACKAGE_REPOS` in a build `profile` to the image builder
 
The `bash onion_buildenv build_all_firmware` script:

- Will compile firmware for the Onion Omega2 and Omega2+
- Output binary files will be in the `output` directory

## Building a Specific Target

By default, the `bash onion_buildenv build_all_firmware` command will build firmware for the target devices specified in the `BUILD_MODELS` variable in `profiles`.

To build for a specific target device, use this command: `bash onion_buildenv build_firmware <target>`

## Adding Packages to the Firmware

OpenWRT packages can be added to the compiled firmware. 

In the `bash onion_buildenv build_all_firmware` script, the env variable `IMAGE_BUILDER_PACKAGES` controls which packages are included in the firmware. Each package has to be added in a new line or in a space separated list.

### Removing Packages from the Firmware

The configuration can be changed so packages that are usually included by default do not get included in the firmware image.

Add the package to be removed with a `-` prefix to the `IMAGE_BUILDER_PACKAGES` variable in the `profile` configuration file.

## The `additions/` Directory

Everything from the `additions/` directory will be copied into the image builder directory before build. 

For example, adding a `additions/files` directory will allow you to include custom files (like [custom configuration files](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#custom_files)) in the firmware image.

> Note: adding .hidden files/directories to the firmware image works, but just not in the `/` directory.

---

# Using this Repo for Development

By default, the firmware will be built including packages from published package repos. Like the the [Onion Package Repo](http://repo.onioniot.com/omega2/packages/onion/) or the [OpenWRT package repo](https://downloads.openwrt.org/releases/22.03.2/targets/ramips/mt76x8/packages/).

While your packages are still in development, it might be useful to work with **local copies** of the packages.

To work with local copies of your packages:

1. Say you've set up the OpenWRT SDK and you're compiling packages to your local machine
2. Update `PACKAGE_REPOS` env variable to point to the local packages. See [`profiles/README.md`](./profiles/README.md) for details.
3. Make any changes to your packages and compile them into IPK files
4. Run `bash onion_buildenv setup_imagebuilder` to download and setup the image builder
5. Run `bash onion_buildenv build_firmware <target>` to build the firmware
6. Find the compiled firmware in the `output` directory
7. Test the firmware on your device. If more changes to your packages are required, start again from step 3


## Example

Say we've used the OpenWRT SDK to build packages locally and the output files can be found at the `/home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/custom/` directory.
And say we wanted to build firmware that uses those locally compiled packages, we would do the following:

1. Update `PACKAGE_REPOS` env variable in a profile file:
    * comment out the existing line
    * add a new line: `PACKAGE_REPOS="src custom file:///home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/custom/"`
2. Make any changes to your packages and compile them into IPK files
3. Run `bash onion_buildenv setup_imagebuilder` to download and setup the image builder
4. Run `bash onion_buildenv build_firmware <target>` to build the firmware
5. Find the compiled firmware in the `output` directory

