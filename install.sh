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

# install gvim and vundle plugins
sudo vim/install_gvim_and_plugins.sh

# install tmux and tpm plugins
sudo tmux/install_tmux_and_plugins.sh

# update CRAN debian repo
sudo R/update_ubuntu_R_repo.sh

