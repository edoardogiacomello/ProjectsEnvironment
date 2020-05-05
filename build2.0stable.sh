#!/bin/bash
# This build is for running the SegAN-CAT and DCSeg models. I noticed model output differs between 2.0.0b1 and 2.0 stable. 

TFVERSION=2.0.0-gpu-py3
docker build --build-arg tfversion=$TFVERSION -t edoardogiacomello/projectenv:$TFVERSION .
