#!/bin/bash

packageInput="$1"

buildImage () {
    local profile="$1"
    local packages="$2"
    
    local filesCommand="FILE=files/"
    if [ ! -d ./files ]; then
        filesCommand=""
    fi
    
    if [ "$packages" == "" ]; then
        make image PROFILE=$profile $filesCommand
    else
        make image PROFILE=$profile PACKAGES="$packages" $filesCommand
    fi

    if [ $? -ne 0 ]; then
        echo "ERROR during image building for $profile"
        exit 1
    fi
}

buildImage onion_omega2 "$packageInput"
buildImage onion_omega2p "$packageInput"
