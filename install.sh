#!/bin/bash

# 0. clean up translation packages
# 1. install JDK 7 and wget postgres JDBC driver
# 2. zsh
# 3. gvim
# 5. update repo for R and install latest version
# 6. install desired R packages and necessary library headers
# 4. tmux -- depends on R, for version checks

sudo sh remove_translation_packages.sh 
if [ ! $? -eq 0 ]; then
  echo "remove_translation_packages.sh failed..."
  exit 1
fi

sudo sh misc/install_jdk_and_postgres_driver.sh
if [ ! $? -eq 0 ]; then
  echo "misc/install_jdk_and_postgres_driver.sh failed..."
  exit 1
fi

sudo sh zsh/install_git_and_zsh.sh
if [ ! $? -eq 0 ]; then
  echo "zsh/install_git_and_zsh.sh failed..."
  exit 1
fi

sudo sh vim/install_gvim_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "vim/install_gvim_and_plugins.sh failed..."
  exit 1
fi

sudo sh R/update_ubuntu_R_repo.sh
if [ ! $? -eq 0 ]; then
  echo "R/update_ubuntu_R_repo.sh failed..."
  exit 1
fi

sudo sh R/install_R_package_dependencies.sh
if [ ! $? -eq 0 ]; then
  echo "R/install_R_package_dependencies.sh failed..."
  exit 1
fi 

sudo sh tmux/install_tmux_and_plugins.sh
if [ ! $? -eq 0 ]; then
  echo "tmux/install_tmux_and_plugins.sh failed..."
  exit 1
fi 
