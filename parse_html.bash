#!/usr/bin/env bash

htmlgetnext(){
    local IFS='<'
    read -d '>' TAG VALUE
}

cat ./index.html | while htmlgetnext ; do echo $TAG; done
