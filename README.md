# OpenWRT Imagebuilder Wrapper

Tools to build OpenWRT firwmare for the Omega2 and Omega2+ using the OpenWRT Image Builder in an easily repeatable and maintainable way.

# How to Use this Repo

1. Run `bash setup.sh` to download and setup the image builder
2. Run `bash build-fw.sh` to build the firmware

# The `additional` Directory

Everything from the `additional` directory will be copied into the image builder directory before build. 

For example, adding a `additional/files` directory will allow you to include [custom configuration files](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#custom_files) in the firmware image.

