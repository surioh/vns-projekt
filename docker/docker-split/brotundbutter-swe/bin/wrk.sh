#!/usr/bin/env bash
source local/config.txt || exit 1
action="$1"
connections="$2"
duration="$3"
[ "$1" = "" ] && action=hello
[ "$2" = "" ] && connections=100
[ "$3" = "" ] && duration=5
threads=$((connections/10))
[ "$threads" = 0 ] && threads=1
wrk -d $duration -c $connections -t $threads $baseurl/$webapp/$action
