#!/bin/sh

docker build -t peterhertkorn/core-dbs2-jammy-x64:ss24 --platform linux/amd64 -f dockerfile-dbs2-core-ss24 .
