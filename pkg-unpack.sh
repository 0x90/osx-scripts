#!/usr/bin/env bash
    filename="$*"
    dirname="${filename/\./_}"
    pkgutil --expand "$filename" "$dirname"
    cd "$dirname"
    tar xvf Payload
    open .

# http://stackoverflow.com/questions/11298855/how-unpack-and-pack-pkg-file