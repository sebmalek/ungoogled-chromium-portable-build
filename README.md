# <img src="logo.png" width="30">  ungoogled-chromium-portable build 

Repo to provide ungoogled-chromium-portable builds to the ungoogled-chromium-binaries site.
The build is an adapted version of the docker build in ungoogled-chromium-portablelinux since I had problems with the clang and linker packages there.
Both portable tar as well as AppImage is packaged.

To execute the build you need a linux with a docker installation running on it. 
If you execute the `build.sh` script, two docker images will be built and tagged locally (if not already locally present):

- a debian-bullseye based image including all the clang and linker stuff
- a chromium-builder image that adds all needed dependencies for building chromium

Then the ungoogled-chromium-portablelinux is cloned and the latest tag of it is checked out and build within a container on the chromium-builder image.
On my Laptop the build takes about 5 and a half hours.
Afterwards you can run the `package.sh` script that will both package a .tar.xz and an AppImage. You can delete the ungoogled-chromium-portablelinux afterwards (it has a size of about 15G after building ;-) )
