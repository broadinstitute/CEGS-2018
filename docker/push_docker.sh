#!/bin/sh

set -ev

VERSION=`cat VERSION.txt`

docker push broadcegs/scell2018:${VERSION}
docker push broadcegs/scell2018:latest

