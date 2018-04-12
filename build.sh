#!/bin/bash
set -eu
cd ${0%/*}

echo building sonicpi-server
docker build -t sonicpi-server .
