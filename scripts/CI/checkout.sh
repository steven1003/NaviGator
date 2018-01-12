#!/bin/sh

source ~/.mil/milrc > /dev/null 2>&1
git submodule update --init --recursive
ln -s $PWD $CATKIN_DIR/src/NaviGator
git clone --recursive https://github.com/uf-mil/mil_common $CATKIN_DIR/src/mil_common