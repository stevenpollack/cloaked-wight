#!/bin/bash

# 1. zsh
# 2. gvim
# 3. tmux
# 4. update repo for R and install latest version

#  remove translational packages
sudo remove_translation_packages.sh

# check for zsh and install
sudo zsh/install_git_and_zsh.sh

# install gvim and vundle plugins
sudo vim/install_gvim_and_plugins.sh

# install tmux and tpm plugins
sudo tmux/install_tmux_and_plugins.sh

# update CRAN debian repo
sudo R/update_ubuntu_R_repo.sh

