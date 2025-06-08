#!/bin/bash
random=$((RANDOM % 100 + 1))
wrk -c 1000 -t20 -d 10 http://localhost:9000/app/read?id=$random
