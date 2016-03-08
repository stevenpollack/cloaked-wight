#!/bin/bash

echo "Installing libcurl4-openssl for devtools..."
sudo apt-get install -y libcurl4-openssl-dev 

echo "creating .Rprofile symlink..."
# this script is either being called from $cloaked-wight or
# $cloaked-wight/R
RPROFILE=$(pwd)/R/.Rprofile
if [ ! -f $RPROFILE ]; then # we're being called from $cloaked-wight/vim
  RPROFILE=$(pwd)/.Rprofile
fi

if [ ! -f $RPROFILE ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or R/ sub-dir"
  exit 1
fi

echo Linking ~/.Rprofile "->" $RPROFILE ...
ln -fs $RPROFILE ~/.Rprofile

echo "install_R_package_dependencies.sh: done..."
