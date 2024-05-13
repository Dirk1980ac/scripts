#!/bin/sh

sourceExtension=$1 # e.g. "mp3"
targetExtension=$2 # e.g. "wav"
deleteSourceFile=$3 # "delete" or omitted
IFS=$'\n'; set -f

for sourceFile in $(find . -iname "*.$sourceExtension")
do
    targetFile="${sourceFile%.*}.$targetExtension"
    ffmpeg -i "$sourceFile" "$targetFile"
    if [ "$deleteSourceFile" == "delete" ]; then
        if [ -f "$targetFile" ]; then
            rm "$sourceFile"
        fi
    fi
done
unset IFS; set +f