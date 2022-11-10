# OpenWRT Imagebuilder Wrapper

Tools to build OpenWRT firwmare for the Omega2 and Omega2+ using the [OpenWRT Image Builder](https://openwrt.org/docs/guide-user/additional-software/imagebuilder) in an easily repeatable and maintainable way.

# How to Use this Repo

> By default, this repo is setup to build OpenWRT firmware for the Onion Omega2 and Omega2+

1. Run `bash setup.sh` to download and setup the image builder
2. Run `bash build-fw.sh` to build the firmware
3. Find the compiled firmware in the `openwrt-imagebuilder/bin/targets/ramips/mt76x8/` directory

## Details

The `setup.sh` script:

- Will download and setup the OpenWRT image builder
- Add the package repo specified in `config/new-repositories.conf` to the image builder repository feeds
 
The `build-fw.sh` script:

- Will compile firmware for the Onion Omega2 and Omega2+
- Output binary files will be in the `openwrt-imagebuilder/bin/targets/ramips/mt76x8/` directory

## Adding Packages to the Firmware

OpenWRT packages can be added to the compiled firmware. 

In the `build-fw.sh` script, the line that specifies the `packages` variable controls which packages are included in the firmware. Packages should be in a space separated list.

## The `additions/` Directory

Everything from the `additions/` directory will be copied into the image builder directory before build. 

For example, adding a `additions/files` directory will allow you to include [custom configuration files](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#custom_files) in the firmware image.

---

# Using this Repo for Development

By default, the firmware will be built including packages from published package repos. Like the the [Onion Package Repo](http://repo.onioniot.com/omega2/packages/onion/) or the [OpenWRT package repo](https://downloads.openwrt.org/releases/22.03.2/targets/ramips/mt76x8/packages/).

While your packages are still in development, it might be useful to work with **local copies** of the packages.

To work with local copies of your packages:

1. Say you've set up the OpenWRT SDK and you're compiling packages to your local machine
2. Update `config/new-repositories.conf` to point to the local packages. See [`config/README.md`](./config/README.md) for details.
3. Make any changes to your packages and compile them into IPK files
4. Run `bash setup.sh` to download and setup the image builder
5. Run `bash build-fw.sh` to build the firmware
6. Find the compiled firmware in the `openwrt-imagebuilder/bin/targets/ramips/mt76x8/` directory
7. Test the firmware on your device. If more changes to your packages are required, start again from step 3


## Example

Say we've used the OpenWRT SDK to build packages locally and the output files can be found at the `/home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/custom/` directory.
And say we wanted to build firmware that uses those locally compiled packages, we would do the following:

1. Update `config/new-repositories.conf`:
    * comment out the existing line
    * add a new line: `src custom file:///home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/custom/`
2. Make any changes to your packages and compile them into IPK files
3. Run `bash setup.sh` to download and setup the image builder
4. Run `bash build-fw.sh` to build the firmware
5. Find the compiled firmware in the `openwrt-imagebuilder/bin/targets/ramips/mt76x8/` directory

