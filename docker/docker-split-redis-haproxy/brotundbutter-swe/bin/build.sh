#!/usr/bin/env bash
bin/clean.sh &&
bin/prepare.sh &&
bin/compile.sh &&
bin/assemble.sh &&
bin/deploy.sh 8080 && 
bin/deploy.sh 8081 &&
bin/check.sh 8080 1 &&
bin/check.sh 8081 2 
