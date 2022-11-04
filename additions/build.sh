#!/bin/bash

packageInput="$1"

buildImage () {
    local profile="$1"
    local packages="$2"

    local packagesCommand="PACKAGES=\"$packages\""
    if [ "$packages" == "" ]; then
      packagesCommand=""
    fi

    echo make image PROFILE=$profile $packagesCommand
    #make image PROFILE=$profile PACKAGES="$packages" FILES=files/

    if [ $? -ne 0 ]; then
        echo "ERROR during image building for $profile"
        exit 1
    fi
}

buildImage onion_omega2 "$packageInput"
buildImage onion_omega2p "$packageInput"
