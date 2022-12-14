#!/bin/bash

export EMCC_CFLAGS="-O2"
ZLIB_PKGVER=1.2.11
LIBTIFF_PKGVER=4.0.10
LIBJPEG_PKGVER=9c

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMP_DIR="/tmp/libtiff"
OUTPUT_DIR="/out"

emcc -o ${OUTPUT_DIR}/libtiff-wasm.raw.js \
    -I ${TMP_DIR}/tiff-${LIBTIFF_PKGVER}/libtiff \
    --memory-init-file 0 \
    --bind -l"workerfs.js" \
    -s FORCE_FILESYSTEM=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s WASM=1 \
    -s EXPORTED_FUNCTIONS="["\
"'_TIFFOpen',"\
"'_TIFFClose',"\
"'_TIFFGetField',"\
"'_TIFFReadRGBAImage',"\
"'_TIFFReadRGBAImageOriented',"\
"'_TIFFNumberOfDirectories',"\
"'_TIFFSetDirectory',"\
"'_TIFFCurrentDirectory',"\
"'_TIFFLastDirectory',"\
"'_TIFFReadDirectory',"\
"'_TIFFNumberOfStrips',"\
"'_TIFFReadEncodedStrip',"\
"'_TIFFStripSize',"\
"'__TIFFmalloc',"\
"'__TIFFfree',"\
"'_GetField',"\
"'_GetStringField',"\
"'_ReadDirectory',"\
"'_SetDirectory',"\
"'_LastDirectory']"\
    -s EXPORTED_RUNTIME_METHODS="['FS', 'cwrap', 'ccall']" \
    ${SRC_DIR}/export.c \
    ${TMP_DIR}/tiff-${LIBTIFF_PKGVER}/libtiff/.libs/libtiff.a \
    ${TMP_DIR}/zlib-${ZLIB_PKGVER}/libz.a \
    ${TMP_DIR}/jpeg-${LIBJPEG_PKGVER}/.libs/libjpeg.a

