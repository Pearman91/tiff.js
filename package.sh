#!/bin/bash

export EMCC_CFLAGS="-O2"
ZLIB_PKGVER=1.2.11
LIBTIFF_PKGVER=4.0.10
LIBJPEG_PKGVER=9c
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

emcc -o tiff.raw.js \
    -I ./tiff-${LIBTIFF_PKGVER}/libtiff \
    --memory-init-file 0 \
	-s FORCE_FILESYSTEM=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s EXPORTED_FUNCTIONS="["\
"'_TIFFOpen',"\
"'_TIFFClose',"\
"'_TIFFGetField',"\
"'_TIFFReadRGBAImage',"\
"'_TIFFReadRGBAImageOriented',"\
"'_TIFFSetDirectory',"\
"'_TIFFCurrentDirectory',"\
"'_TIFFReadDirectory',"\
"'_TIFFNumberOfStrips',"\
"'_TIFFReadEncodedStrip',"\
"'_TIFFStripSize',"\
"'__TIFFmalloc',"\
"'__TIFFfree',"\
"'_GetField']"\
	-s EXTRA_EXPORTED_RUNTIME_METHODS=['FS'] \
    export.c \
    tiff-${LIBTIFF_PKGVER}/libtiff/.libs/libtiff.a \
    zlib-${ZLIB_PKGVER}/libz.a \
    jpeg-${LIBJPEG_PKGVER}/.libs/libjpeg.a

