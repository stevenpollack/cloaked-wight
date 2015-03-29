#!/bin/bash

# 1. zsh
# 2. gvim
# 3. tmux
# 4. update repo for R and install latest version

#  remove translational packages
sudo remove_translation_packages.sh

# check for zsh and install
echo "checking... zsh"
if [ $(which zsh | grep -c "not found") -eq 1 ]; then
  echo "zsh is missing. Will sudo apt-get install now..."
  sudo apt-get install -y zsh
else
  echo "zsh is installed."
fi

# check for gvim and install
echo "checking... gvim"
if [ $(which gvim | grep -c "not found") -eq 1 ]; then
  echo "gvim is missing. Will sudo apt-get install now..."
  sudo apt-get install -y vim-gnome
else
  echo "gvim is installed."
fi

# install tmux and tpm plugins
sudo tmux/install_tmux_and_plugins.sh

# update CRAN debian repo
sudo R/update_ubuntu_R_repo.sh

