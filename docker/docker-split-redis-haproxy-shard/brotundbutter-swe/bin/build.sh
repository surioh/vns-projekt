#!/usr/bin/env bash
bin/clean.sh &&
bin/prepare.sh &&
bin/compile.sh &&
bin/assemble.sh &&
bin/deploy.sh 8080 &&
bin/deploy.sh 8081 &&
bin/deploy.sh 8082 &&
bin/deploy.sh 8083 && 
bin/check-read.sh 8082 1 &&
bin/check-read.sh 8083 2 &&
bin/check-write.sh 8080 &&
bin/check-write.sh 8081
