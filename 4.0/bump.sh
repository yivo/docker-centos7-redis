#!/usr/bin/env bash

set -e

docker build --tag eahome00/centos7-redis:4.0.6 \
             --tag eahome00/centos7-redis:4.0 \
             --tag eahome00/centos7-redis:4 \
             --tag eahome00/centos7-redis:latest \
             .

docker push eahome00/centos7-redis:4.0.6
docker push eahome00/centos7-redis:4.0
docker push eahome00/centos7-redis:4
docker push eahome00/centos7-redis:latest
