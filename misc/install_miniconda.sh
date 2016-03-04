#!/bin/bash

if [ -z $ANACONDA ]; then
  echo "Error \$ANACONDA is not set; cannot install conda..."
  exit 1 
fi

echo "Installing miniconda..."

# install anaconda according to $ANACONDA system variable
miniconda=Miniconda3-latest-Linux-x86_64.sh

if [ ! -e $miniconda ]; then
  wget http://repo.continuum.io/miniconda/$miniconda
fi

chmod +x $miniconda
bash $miniconda -b -p $ANACONDA

echo "conda installation complete..."
