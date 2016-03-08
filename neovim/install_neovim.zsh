#!/usr/bin/env zsh -i

# This script should be called from either the root of cloaked-wight
# or cloaked-wight/neovim (due to symbolic linking). This could be
# alleviated with a curl of the file from github, but I'm trying to
# keep the curling to a minimum.
#
# The script also assumes that conda is already installed and
# accessible via $PATH 

echo "install_neovim: starting..."

# install silversearcher
echo "Checking for silversearcher..."
ag --version 2>&1 > /dev/null
AG_IS_AVAILABLE=$?
if [ ! $AG_IS_AVAILABLE -eq 0 ]; then
  echo "ag not found... installing via apt-get..."
  sudo apt-get install -y silversearcher-ag
else
  echo $(ag --version) "is installed..."
fi

echo "Checking for xclip..."
xclip -version 2>&1 >/dev/null # suppress output
XCLIP_IS_AVAILABLE=$?
if [ ! $XCLIP_IS_AVAILABLE -eq 0 ]; then
  echo "xclip is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y xclip > /dev/null || \
    echo "xclip failed to install..."
else
  echo $(xclip -version) is installed to $(which xclip)
fi

# check for neovim and install
echo "Checking for neovim..."
nvim --version 2>&1 > /dev/null # suppress output
NVIM_IS_AVAILABLE=$?
if [ ! $NVIM_IS_AVAILABLE -eq 0 ]; then
  echo "nvim is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y software-properties-common  > /dev/null
  sudo add-apt-repository -y ppa:neovim-ppa/unstable > /dev/null
  sudo apt-get update > /dev/null
  sudo apt-get install -y neovim || {
    echo "neovim failed to install...";
    exit 1;
  }
else
  echo "neovim is installed..." 
fi


echo "installing jedi and neovim python packages..."
conda install -y jedi
pip install neovim

# make ~/.config/nvim directory
mkdir -p ${NVIM_HOME:=$HOME/.config/nvim}

# install vim-plug
VIMPLUG_DIR=$NVIM_HOME/autoload
if [ ! -d $VIMPLUG_DIR ]; then

  echo "installing vim-plug..."

  # check that curl is installed
  curl --version 2>&1 > /dev/null
  CURL_IS_INSTALLED=$?
  if [ ! $CURL_IS_INSTALLED -eq 0 ]; then
    sudo apt-get install -y curl > /dev/null || {
    echo "curl failed to install => vim-plug cannot install. Aborting...";
    exit 1;
  }
  fi

  curl -fLo $VIMPLUG_DIR/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install powerline fonts for vim-airline
if [ ! -d ~/.powerline_fonts ]; then
  git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
  ~/.powerline_fonts/install.sh
fi

echo Setting up symbolic links...

# this script is either being called from $cloaked-wight or
# $cloaked-wight/nvim
NVIMRC=$(pwd)/neovim/init.vim
if [ ! -f $NVIMRC ]; then # we're being called from $cloaked-wight/nvim
  NVIMRC=$(pwd)/init.vim
fi

if [ ! -f $NVIMRC ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or nvim/ sub-dir"
  exit 1
fi

echo "Linking ~/.nvimrc -> $NVIMRC..."
ln -fs $NVIMRC ~/.nvimrc 

INIT_VIM=$NVIM_HOME/init.vim
echo "Linking ~/.nvimrc and $INIT_VIM..."
ln -fs ~/.nvimrc $INIT_VIM

# run the plugin installs:
# note that we have to compile VimProc
echo Installing neovim plugin-ins...
nvim -c PlugInstall -c qall
nvim -c VimProcInstall -c qall

echo "install_neovim: done..."
