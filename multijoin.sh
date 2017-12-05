#!/bin/bash

function MULTIJOIN_doTempCopyFromFile() {
    local input=$1
    local dest=$(mktemp)
    cp $input $dest
    echo "$dest"
    return 0
}

function MULTIJOIN_doTempCopyFromStdin() {
    local dest=$(mktemp)
    while read line ;  do
        echo "$line" >>$dest;
    done <"${1:-/dev/stdin}"
    echo "$dest"
    return 0
}


if [ -f "$1" ] ; then
    copy1=$(MULTIJOIN_doTempCopyFromFile $1)
else
    copy1=$(MULTIJOIN_doTempCopyFromStdin <"${1:-/dev/stdin}")
fi
echo "copy1: $copy1"
cat $copy1

if [ -f "$2" ] ; then
    copy2=$(MULTIJOIN_doTempCopyFromFile $2)
else
    copy2=$(MULTIJOIN_doTempCopyFromStdin <"${2:-/dev/stdin}")
fi
echo "copy2: $copy2"
cat $copy2

