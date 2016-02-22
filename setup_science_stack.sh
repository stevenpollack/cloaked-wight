# 2. install python
# 4. gvim
# 5. tmux -- depends on python, for version checks
# 6. update repo for R and install latest version
# 7. install desired R packages and necessary library headers

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

source miniconda/install_miniconda.sh
if [ ! $? -eq 0 ]; then
  echo "miniconda/install_miniconda.sh failed..."
  exit 1
fi 

source R/install_R_package_dependencies.sh
if [ ! $? -eq 0 ]; then
  echo "R/install_R_package_dependencies.sh failed..."
  exit 1
fi 


