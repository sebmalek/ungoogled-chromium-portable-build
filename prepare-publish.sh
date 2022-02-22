#!/bin/bash

PATH_TO_BUILD_GIT_REPO="~/workspace/ungoogled-software/ungoogled-chromium-portablelinux/"
PATH_TO_PUBLISH_GIT_REPO="~/workspace/clickot/ungoogled-chromium-binaries/"

TAG="$(cd ${PATH_TO_BUILD_GIT_REPO} && git describe --tags --abbrev=0)"

cd ${PATH_TO_PUBLISH_GIT_REPO}
git pull --rebase
./utilities/submit_github_binary.py --tag ${TAG} --username clickot --output config/platforms/linux_portable/64bit/ ~/software/ungoogled-chromium/ungoogled-chromium_${TAG}*.tar.xz 
./utilities/submit_github_binary.py --tag ${TAG} --username clickot --output config/platforms/appimage/64bit/ ~/software/ungoogled-chromium/ungoogled-chromium_${TAG}*.AppImage 

