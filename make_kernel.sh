#!/bin/bash

KERNEL_DIR=/emazys/linux
OUTDIR=/mnt/host/rootfs

echo "Welcome to EmaZys toolchain. We are now ready to build the linux Kernel"

cd /emazys
git clone https://github.com/beagleboard/linux.git ${KERNEL_DIR}
cd linux

git checkout 3.14.35-ti-r56
echo "Applying patch"
patch -p1 < /emazys/mmc.patch
echo "Patch applied"
cp /emazys/config-3.14.35-ti-r56 ${KERNEL_DIR}/.config
echo "Compiling kernel"
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j8
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x82000000 uImage dtbs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j8 modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=${OUTDIR} modules_install
make headers_install ARCH=arm INSTALL_HDR_PATH=${OUTDIR}/usr
echo "Compiling driver for RTL8188EUS (EW-7811Un-V2)"¨
cd /emazys/rtl8188EUS_linux_v5.7.6.1_36803.20200508
make modules
echo "Finnished compiling"

mkdir -p ${OUTDIR}
cp -a ${KERNEL_DIR}/arch/arm/boot ${OUTDIR}
cp /emazys/rtl8188EUS_linux_v5.7.6.1_36803.20200508/8188eu.ko ${OUTDIR}/lib/modules/3.14.35+/kernel/drivers/net/wireless
cp /emazys/rtl8188EUS_linux_v5.7.6.1_36803.20200508/8188eu.ko ${OUTDIR}
echo "zImage and 8188eu.ko can be found in the rootfs directory"
