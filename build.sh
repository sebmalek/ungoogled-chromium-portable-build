#!/bin/bash
BASE_IMAGE="debian-bullseye:clang-15"
IMAGE="chrome-builder:latest"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

sudo rm -rf $BASE_DIR/ungoogled-chromium-portablelinux 

if [ -z "$(docker images -q ${BASE_IMAGE})" ] ; then
    echo -e "image ${BASE_IMAGE} not found, building it first.\n"
    cd $BASE_DIR/docker && docker build -t ${BASE_IMAGE} -f Dockerfile-clang .
else
   echo -e "found base image ${BASE_IMAGE}.\n"
fi
if [ -z "$(docker images -q ${IMAGE})" ] ; then
    echo -e "image ${IMAGE} not found, building it first.\n"
    cd $BASE_DIR/docker && docker build -t ${IMAGE} .
else
   echo -e "found image ${IMAGE}, using it for building.\n"
fi

cd $BASE_DIR 
git clone --recurse-submodules https://github.com/ungoogled-software/ungoogled-chromium-portablelinux.git
cd ungoogled-chromium-portablelinux
GIT_TAG=$(git describe --tags --abbrev=0)
echo "git checkout --recurse-submodules ${GIT_TAG}"
git checkout --recurse-submodules ${GIT_TAG}

# patch build.sh to use clang-15 per default
#sed -i 's|export LLVM_VERSION=${LLVM_VERSION:=13}|export LLVM_VERSION=${LLVM_VERSION:=15}|' build.sh

BUILD_START=$(date)
echo "==============================================================="
echo "  build start at ${BUILD_START}"
echo "==============================================================="

cd ${BASE_DIR}

docker run -it -v ${BASE_DIR}:/build ${IMAGE} /bin/bash -c 'LLVM_VERSION=15 /build/ungoogled-chromium-portablelinux/build.sh'

BUILD_END=$(date)
echo "==============================================================="
echo "  build start at ${BUILD_START}"
echo "  build end   at ${BUILD_END}"
echo "==============================================================="

