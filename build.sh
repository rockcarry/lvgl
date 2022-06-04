#!/bin/sh

set -e

mkdir $PWD/build
cd $PWD/build
cmake -DCMAKE_INSTALL_PREFIX=$PWD/_install ..
make -j8
make install
cd -

