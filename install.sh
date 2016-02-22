#!/bin/bash

# 0. clean up translation packages
# 1. zsh
# 2. install python
# 3. install JDK 7 and wget postgres JDBC driver
# 4. gvim
# 5. tmux -- depends on python, for version checks
# 6. update repo for R and install latest version
# 7. install desired R packages and necessary library headers

sudo sh remove_translation_packages.sh 
if [ ! $? -eq 0 ]; then
  echo "remove_translation_packages.sh failed..."
  exit 1
fi

sudo sh zsh/install_git_and_zsh.sh
if [ ! $? -eq 0 ]; then
  echo "zsh/install_git_and_zsh.sh failed..."
  exit 1
fi 

bash miniconda/install_miniconda.sh
if [ ! $? -eq 0 ]; then
  echo "miniconda/install_miniconda.sh failed..."
  exit 1
fi 

#sudo sh misc/install_jdk_and_postgres_driver.sh
if [ ! $? -eq 0 ]; then
  echo "misc/install_jdk_and_postgres_driver.sh failed..."
  exit 1
fi

sudo sh vim/install_gvim_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "vim/install_gvim_and_plugins.sh failed..."
  exit 1
fi

sudo sh tmux/install_tmux_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "tmux/install_tmux_and_plugins.sh failed..."
  exit 1
fi 

# sudo sh R/update_ubuntu_R_repo.sh
if [ ! $? -eq 0 ]; then
  echo "R/update_ubuntu_R_repo.sh failed..."
  exit 1
fi

sudo bash R/install_R_package_dependencies.sh
if [ ! $? -eq 0 ]; then
  echo "R/install_R_package_dependencies.sh failed..."
  exit 1
fi 


