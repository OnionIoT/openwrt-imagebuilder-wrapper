# Image Builder Repository Configuration

> > The `setup.sh` script will append what's in the `new-repositories.conf` file to the feed configuration file in the downloaded OpenWRT Image Builder.

Have two options when specifying package repositories for the Image Builder:

1. Point to an package repository publihsed online
2. Point to a local package repository

## Default: Point to package repository published online 

By default, the `new-repositories.conf` file will point to package repos on http://repo.onioniot.com

This is useful for Continuous Integration.

## Alternative for Development 

During development, there might be a need to pull compiled packages from a local source.


In that case, change the contents of `new-repositories.conf` to:

```
src custom file:///home/ubuntu/openwrt-sdk-wrapper/openwrt-sdk/bin/packages/mipsel_24kc/onion
```

And run the `setup.sh` script again.