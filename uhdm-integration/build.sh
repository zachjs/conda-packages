#!/bin/bash

set -e
set -x

if [ x"$TRAVIS" = xtrue ]; then
	CPU_COUNT=2
fi

export PKG_CONFIG_PATH="$BUILD_PREFIX/lib/pkgconfig/"
export CXXFLAGS="$CXXFLAGS -I$BUILD_PREFIX/include"
export LDFLAGS="$CXXFLAGS -L$BUILD_PREFIX/lib -lrt -ltinfo"

make -j$CPU_COUNT surelog/parse
make -j$CPU_COUNT uhdm/build
make -j$CPU_COUNT uhdm/verilator/build
make -j$CPU_COUNT ENABLE_READLINE=0 yosys/yosys

