#!/usr/bin/env bash
source local/config.txt || exit 1
baseurl="http://localhost:$1"
path="$baseurl/$webapp"
curl -s "$path/assembled.txt"
curl -s "$path/hello"
curl -s "$path/read?id=$2"
curl -s "$path/read?id=$2"
