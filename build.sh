#!/usr/bin/env bash

set -e

BUILD_MODULE=$1
BUILD_DATE=`date +%Y%m%d%H%M%S`
BUILD_BRANCH=`git symbolic-ref --short -q HEAD`
BUILD_COMMIT_HASH=`git rev-parse --short HEAD`
BUILD_IMAGE_NAME=""

if [ -z "${BUILD_MODULE}" ]; then
    echo -e "\033[31mERROR: BUILD_MODULE is empty!\033[0m"
    echo -e "\033[32mExample: $0 master"
    exit 1
else
    BUILD_IMAGE_NAME=skywalking-collector-storage-${BUILD_MODULE}:`echo ${BUILD_BRANCH} | tr '/' '-'`-${BUILD_COMMIT_HASH}
fi

echo -e "\033[32mBuild docker image ==> ${BUILD_IMAGE_NAME}\033[0m"

docker build -t ${BUILD_IMAGE_NAME} ${BUILD_MODULE}

echo -e "\033[32mDocker image ==> ${BUILD_IMAGE_NAME} build success!\033[0m"
