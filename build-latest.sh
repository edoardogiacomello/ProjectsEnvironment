#!/bin/bash
# This build pulls the latest from tensorflow dockerhub. It may not work with your Cuda version. 

TFVERSION=latest-gpu-py3
docker build --build-arg tfversion=$TFVERSION -t edoardogiacomello/projectenv:$TFVERSION .
