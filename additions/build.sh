#!/bin/bash

buildImage () {
    local profile="$1"

    make image PROFILE="$profile"
    if [ $? -ne 0 ]; then
        echo "ERROR during image building for $profile"
        exit 1
    fi 
}

buildImage onion_omega2p
