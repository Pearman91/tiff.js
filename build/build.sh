#!/bin/bash

export EMCC_CFLAGS="-O2"
ZLIB_PKGVER=1.2.11
LIBTIFF_PKGVER=4.0.10
LIBJPEG_PKGVER=9c
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# build zlib
wget http://zlib.net/fossils/zlib-${ZLIB_PKGVER}.tar.gz
tar xf zlib-${ZLIB_PKGVER}.tar.gz
rm zlib-${ZLIB_PKGVER}.tar.gz
cd zlib-${ZLIB_PKGVER}
emconfigure ./configure --static
emmake make
cd ..

# build libjpeg
wget http://www.ijg.org/files/jpegsrc.v${LIBJPEG_PKGVER}.tar.gz
tar xf jpegsrc.v${LIBJPEG_PKGVER}.tar.gz
rm jpegsrc.v${LIBJPEG_PKGVER}.tar.gz
cd jpeg-${LIBJPEG_PKGVER}
emconfigure ./configure --enable-shared=no
emmake make clean # do not ask me why i have to clean here...
emmake make
cd ..

# # build libtiff
wget http://download.osgeo.org/libtiff/tiff-${LIBTIFF_PKGVER}.tar.gz
tar xzvf tiff-${LIBTIFF_PKGVER}.tar.gz
rm tiff-${LIBTIFF_PKGVER}.tar.gz
cd tiff-${LIBTIFF_PKGVER}
emconfigure ./configure \
            --with-zlib-include-dir=${DIR}/zlib-${ZLIB_PKGVER}/ \
            --with-zlib-lib-dir=${DIR}/zlib-${ZLIB_PKGVER}/ \
            --with-jpeg-include-dir=${DIR}/jpeg-${LIBJPEG_PKGVER}/ \
            --with-jpeg-lib-dir=${DIR}/jpeg-${LIBJPEG_PKGVER}/.libs/ \
            --enable-shared=no
emmake make
cd ..

. ${DIR}/package.sh

