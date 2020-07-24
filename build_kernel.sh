#!/bin/bash

#SETUP BUILD ENVIROMENT
#
export ARCH=arm
export PATH=/home/yes/android-toolchain/arm-linux-androideabi-4.9-refs_heads_brillo-m7-mr-dev/bin:$PATH

#CLEAN SOURCE
#
OUTDIR=out
rm -rf $OUTDIR
mkdir $OUTDIR
make clean  $OUTDIR && make mrproper $OUTDIR

#MAKE DEFCONFIG
#
CCV="CROSS_COMPILE=arm-linux-androideabi-"
ODV="O=$OUTDIR"
make -C $(pwd) $ODV $CCV j4primelte_sea_open_defconfig

#GET CPU COUNT AND BUILD
#
CORE_COUNT=`grep processor /proc/cpuinfo|wc -l`
make -j$CORE_COUNT -C $(pwd) $ODV $CCV
cp $OUTDIR/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
