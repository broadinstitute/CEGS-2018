#!/bin/sh

set -ev

VERSION=`cat VERSION.txt`

docker build -t broadcegs/scell2018:$VERSION .
docker build -t broadcegs/scell2018:latest .


