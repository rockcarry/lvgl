#!/bin/sh

set -e

if [ "$LVGL_PORT_PLATFORM"x == ""x ]; then
    LVGL_PORT_PLATFORM="win32"
fi

LVGL_TOP_DIR=$PWD
LVGL_BUILD_DIR=$LVGL_TOP_DIR/build
LVGL_PLATFORM_DIR=$LVGL_TOP_DIR/$LVGL_PORT_PLATFORM
LVGL_INSTALL_DIR=$LVGL_BUILD_DIR/_install
LVGL_INCLUDE_DIR=$LVGL_BUILD_DIR/_install/include/lvgl
LVGL_LIB_DIR=$LVGL_BUILD_DIR/_install/lib

case "$1" in
"")
    if [ ! -d $LVGL_BUILD_DIR ]; then
        mkdir $LVGL_BUILD_DIR
        cd $LVGL_BUILD_DIR
        cmake -G"Unix Makefiles" -DCMAKE_C_COMPILER=${CROSS_COMPILE}gcc -DCMAKE_CXX_COMPILER=${CROSS_COMPILE}g++ -DCMAKE_INSTALL_PREFIX=$LVGL_INSTALL_DIR ..
    fi
    cd $LVGL_BUILD_DIR
    make -j8
    make install
    cd $LVGL_TOP_DIR

    if [ -d "$LVGL_PLATFORM_DIR" ]; then
        cd $LVGL_PLATFORM_DIR && ./build.sh && cd $LVGL_TOP_DIR
    fi
    ;;
clean|distclean)
    rm -rf $LVGL_BUILD_DIR
    rm -rf $LVGL_TOP_DIR/hellolvgl.exe
    exit 0
    ;;
esac

CFLAGS="-Wall -I$LVGL_INCLUDE_DIR"
LDFLAGS="-L$LVGL_LIB_DIR -llvgl"

case "$LVGL_PORT_PLATFORM" in
"win32")
    LDFLAGS="$LDFLAGS -lgdi32"
    ;;
*)
    echo "unsupported platform !"
    exit 0
    ;;
esac

${CROSS_COMPILE}gcc -o hellolvgl.exe $CFLAGS $PWD/hellolvgl.c $LDFLAGS
