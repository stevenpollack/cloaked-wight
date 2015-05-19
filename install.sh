#!/bin/bash

# 0. clean up translation packages
# 1. zsh
# 2. gvim
# 3. tmux
# 4. update repo for R and install latest version
# 5. install desired R packages and necessary library headers

sudo sh remove_translation_packages.sh 
sudo sh zsh/install_git_and_zsh.sh
sudo sh vim/install_gvim_and_plugins.sh
sudo sh tmux/install_tmux_and_plugins.sh
sudo sh R/update_ubuntu_R_repo.sh
sudo sh R/install_R_package_dependencies.sh

