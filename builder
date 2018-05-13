#!/bin/bash

docker pull gingerlime/thumbor:latest
echo "--> BUILDING gingerlime/thumbor"
docker build --cache-from gingerlime/thumbor:latest -f thumbor/Dockerfile -t gingerlime/thumbor:latest thumbor/
# introspecting version by running the built image
THUMBOR_VERSION=`docker run --rm gingerlime/thumbor bash -c "pip freeze |grep ^thumbor== | cut -d= -f 3"`
echo "THUMBOR VERSION: $THUMBOR_VERSION"

echo "--> TAGGING gingerlime/thumbor:$THUMBOR_VERSION"
docker tag gingerlime/thumbor gingerlime/thumbor:$THUMBOR_VERSION
echo "--> TAGGING gingerlime/thumbor:latest"
docker tag gingerlime/thumbor gingerlime/thumbor:latest

echo "--> BUILDING gingerlime/thumbor:simd-sse4"
docker build --build-arg SIMD_LEVEL=sse4 -f thumbor/Dockerfile -t gingerlime/thumbor-simd-sse4 thumbor/
echo "--> TAGGING gingerlime/thumbor:$THUMBOR_VERSION-simd-sse4"
docker tag gingerlime/thumbor-simd-sse4 gingerlime/thumbor:$THUMBOR_VERSION-simd-sse4
echo "--> TAGGING gingerlime/thumbor:latest-simd-sse4"
docker tag gingerlime/thumbor-simd-sse4 gingerlime/thumbor:latest-simd-sse4

echo "--> BUILDING gingerlime/thumbor:simd-avx2"
docker build --build-arg SIMD_LEVEL=avx2  -f thumbor/Dockerfile -t gingerlime/thumbor-simd-avx2 thumbor/
echo "--> TAGGING gingerlime/thumbor:$THUMBOR_VERSION-simd-avx2"
docker tag gingerlime/thumbor-simd-avx2 gingerlime/thumbor:$THUMBOR_VERSION-simd-avx2
echo "--> TAGGING gingerlime/thumbor:latest-simd-avx2"
docker tag gingerlime/thumbor-simd-avx2 gingerlime/thumbor:latest-simd-avx2

echo "--> BUILDING gingerlime/thumbor-multiprocess"
docker build --build-arg THUMBOR_TAG=latest -f thumbor-multiprocess/Dockerfile -t gingerlime/thumbor-multiprocess thumbor-multiprocess/
echo "--> TAGGING gingerlime/thumbor-multiprocess:$THUMBOR_VERSION"
docker tag gingerlime/thumbor-multiprocess gingerlime/thumbor-multiprocess:$THUMBOR_VERSION
echo "--> TAGGING gingerlime/thumbor-multiprocess:latest"
docker tag gingerlime/thumbor-multiprocess gingerlime/thumbor-multiprocess:latest

echo "--> BUILDING gingerlime/thumbor-multiprocess:simd-sse4"
docker build --build-arg THUMBOR_TAG=latest-simd-sse4 -f thumbor-multiprocess/Dockerfile -t gingerlime/thumbor-multiprocess-simd-sse4 thumbor-multiprocess/
echo "--> TAGGING gingerlime/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4"
docker tag gingerlime/thumbor-simd-sse4 gingerlime/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4
echo "--> TAGGING gingerlime/thumbor-multiprocess:latest-simd-sse4"
docker tag gingerlime/thumbor-simd-sse4 gingerlime/thumbor-multiprocess:latest-simd-sse4

echo "--> BUILDING gingerlime/thumbor-multiprocess:simd-avx2"
docker build --build-arg THUMBOR_TAG=latest-simd-avx2 -f thumbor-multiprocess/Dockerfile -t gingerlime/thumbor-multiprocess-simd-sse4 thumbor-multiprocess/
echo "--> TAGGING gingerlime/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2"
docker tag gingerlime/thumbor-simd-avx2 gingerlime/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2
echo "--> TAGGING gingerlime/thumbor-multiprocess:latest-simd-avx2"
docker tag gingerlime/thumbor-simd-avx2 gingerlime/thumbor-multiprocess:latest-simd-avx2

echo "--> BUILDING gingerlime/thumbor-nginx"
docker build -f nginx/Dockerfile -t gingerlime/thumbor-nginx nginx/
echo "--> TAGGING gingerlime/thumbor-nginx:$THUMBOR_VERSION"
docker tag gingerlime/thumbor-nginx gingerlime/thumbor-nginx:$THUMBOR_VERSION
echo "--> TAGGING gingerlime/thumbor-nginx:latest"
docker tag gingerlime/thumbor-nginx gingerlime/thumbor-nginx:latest

echo "--> BUILDING gingerlime/remotecv"
docker build --build-arg THUMBOR_TAG=latest -f remotecv/Dockerfile -t gingerlime/remotecv remotecv/
echo "--> TAGGING gingerlime/remotecv:$THUMBOR_VERSION"
docker tag gingerlime/remotecv gingerlime/remotecv:$THUMBOR_VERSION
echo "--> TAGGING gingerlime/remotecv:latest"
docker tag gingerlime/remotecv gingerlime/remotecv:latest

