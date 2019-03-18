#!/bin/bash

export EMCC_CFLAGS="-O2"
ZLIB_PKGVER=1.2.11
LIBTIFF_PKGVER=4.0.10
LIBJPEG_PKGVER=9c
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

emcc -o tiff.raw.js \
    -I ./tiff-${LIBTIFF_PKGVER}/libtiff \
	--post-js post.js \
    --memory-init-file 0 \
	-s FORCE_FILESYSTEM=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
	-s WASM=0 \
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

echo 'var TiffTag = {' > tiff_tag.ts
grep '^#define[[:space:]]\+TIFFTAG_[A-Za-z_]\+[[:space:]]\+' \
    tiff-${LIBTIFF_PKGVER}/libtiff/tiff.h \
    | sed -e "s@^\#define[[:space:]]*TIFFTAG_\([A-Za-z_]*\)[[:space:]]*\([A-Za-z0-9]*\).*@  \1 : \2,@g" \
    >> tiff_tag.ts
echo '};' >> tiff_tag.ts

tsc emscripten.d.ts tiff_tag.ts tiff_api.ts -d
cat LICENSE tiff.raw.js post.js > tiff.js
echo '' >> tiff.js
cat tiff_tag.js tiff_api.js >> tiff.js
mv tiff_api.d.ts tiff.d.ts
rm -f tiff_tag.d.ts tiff_tag.js tiff_api.js

closure-compiler \
    --js=tiff.js \
    --js_output_file=tiff.min.js \
    --language_in ECMASCRIPT5 \
    --output_wrapper="(function() {%output%})();"

