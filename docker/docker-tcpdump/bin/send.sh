#!/bin/bash

docker container cp context/send.sh client:/send.sh && echo "send.sh Shipped"
docker exec -ti client ./send.sh && echo "Data Sent to Server"
