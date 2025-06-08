#!/bin/bash
docker image build -t image-cache context
docker image build -t image-haproxy context -f ./context/Dockerfile-haproxy

