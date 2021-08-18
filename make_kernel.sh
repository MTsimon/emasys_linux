#!/bin/bash

KERNEL_DIR=/emazys/linux
OUTDIR=/emazys/release

echo "Welcome to EmaZys toolchain. We are now ready to build the linux Kernel"

cd /emazys
mkdir release
git clone https://github.com/beagleboard/linux.git ${KERNEL_DIR}
cd linux

git checkout 3.14.35-ti-r56
echo "Applying patch"
patch -p1 < /emazys/mmc.patch
echo "Patch applied"
cp /emazys/config-3.14.35-ti-r56 ${KERNEL_DIR}/.config
echo "Compiling kernel"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j8
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=${OUTDIR} modules_install
echo "Compiling driver for RTL8188EUS (EW-7811Un-V2)"¨
cd /emazys/rtl8188EUS_linux_v5.7.6.1_36803.20200508
make modules
echo "Finnished compiling"
cp ${KERNEL_DIR}/arch/arm/boot/zImage ${OUTDIR}
cp /emazys/rtl8188EUS_linux_v5.7.6.1_36803.20200508/8188eu.ko ${OUTDIR}
echo "zImage and 8188eu.ko can be found in the release directory"
