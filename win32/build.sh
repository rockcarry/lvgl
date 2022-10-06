#!/bin/sh

set -e

LVGL_INSTALL_DIR=$PWD/../build/_install
SRCS=`ls *.c`

${CROSS_COMPILE}gcc -Wall -c -I$LVGL_INSTALL_DIR/include/lvgl $SRCS
${CROSS_COMPILE}ar rcs $LVGL_INSTALL_DIR/lib/liblvgl.a $PWD/*.o
rm $PWD/*.o
