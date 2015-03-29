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

# check for tmux v1.9a
echo "checking... tmux"
if [ $(tmux -V | grep -c "1.9") -eq 1 ]; then
  echo "tmux (>= 1.9) is installed."
else
  echo "tmux is either uninstalled or the wrong version." \ 
  "Will install v1.9a now..."
  sudo apt-get update
  sudo apt-get install -y python-software-properties software-properties-common
  sudo add-apt-repository -y ppa:pi-rho/dev
  sudo apt-get update
  sudo apt-get install -y tmux=1.9a-1~ppa1~t
fi


# update CRAN debian repo
sudo R/update_ubuntu_R_repo.sh

