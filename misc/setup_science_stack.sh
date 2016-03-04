#!/bin/bash

source vim/install_gvim_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "vim/install_gvim_and_plugins.sh failed..."
  exit 1
fi

source tmux/install_tmux_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "tmux/install_tmux_and_plugins.sh failed..."
  exit 1
fi 

source misc/install_miniconda.sh
if [ ! $? -eq 0 ]; then
  echo "miniconda/install_miniconda.sh failed..."
  exit 1
fi 

source R/install_R_package_dependencies.sh
if [ ! $? -eq 0 ]; then
  echo "R/install_R_package_dependencies.sh failed..."
  exit 1
fi 

