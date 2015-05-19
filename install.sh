#!/bin/bash

# 0. clean up translation packages
# 1. install JDK 7 and wget postgres JDBC driver
# 2. zsh
# 3. gvim
# 4. tmux
# 5. update repo for R and install latest version
# 6. install desired R packages and necessary library headers

sudo sh remove_translation_packages.sh 
sudo sh misc/install_jdk_and_postgres_driver.sh
sudo sh zsh/install_git_and_zsh.sh
sudo sh vim/install_gvim_and_plugins.sh
sudo sh tmux/install_tmux_and_plugins.sh
sudo sh R/update_ubuntu_R_repo.sh
sudo sh R/install_R_package_dependencies.sh

