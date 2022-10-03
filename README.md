# tiff.js

tiff.js is a port of the LibTIFF by compiling the LibTIFF C code with Emscripten to WebASM

## Setup and build on vanilla Ubuntu

Tested on Ubuntu 20.04 virtual machine running in Hyper-V.

Install dependencies:

    sudo apt install make
    sudo apt install git

Install and activate emscripten:

    git clone https://github.com/emscripten-core/emsdk.git
    cd emsdk
    git pull
    ./emsdk install latest
    ./emsdk activate latest
    echo 'source "/home/USERNAME/DIRNAME/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile
    source "/home/USERNAME/DIRNAME/emsdk/emsdk_env.sh"

Clone tiff.js repo and build Wasm and JavaScript files:

    cd ..
    git clone https://github.com/Pearman91/tiff.js.git
    cd tiff.js/
    ./build.sh



## Demo

The WebASM compiled version is used by [webgl-neuron](https://github.com/Twinklebear/webgl-neuron).


## License

The LibTIFF is LibTIFF Software License, zlib and additional code are zlib License.
