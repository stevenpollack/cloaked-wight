#!/bin/bash

##################
# NOTE:
# * THIS SCRIPT MUST BE CALLED FROM top-level of repo, OR vim/ sub-dir
################## 

echo "install_gvim_and_plugins: starting..."

# check for gvim and install
echo "Checking for gvim..."
gvim --version 2>&1 > /dev/null # suppress output
GVIM_IS_AVAILABLE=$?
if [ ! $GVIM_IS_AVAILABLE -eq 0 ]; then
  echo "gvim is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y vim-gnome > /dev/null
else
  echo $(gvim --version) "is installed..." 
fi

# install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "installing vundle..."
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install powerline fonts for vim-airline
if [ ! -d ~/.powerline_fonts ]; then
  git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
  sudo ~/.powerline_fonts/install.sh
fi

# make symlink to vim/.vimrc
echo "making symlink to vim/.vimrc..."

# this script is either being called from $cloaked-wight or
# $cloaked-wight/vim
VIMRC=$(pwd)/vim/.vimrc
if [ ! -f $VIMRC ]; then # we're being called from $cloaked-wight/vim
  VIMRC=$(pwd)/.vimrc
fi

if [ ! -f $VIMRC ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or vim/ sub-dir"
  exit
fi

echo "Linking ~/.vimrc ->" $VIMRC ...
ln -fs $VIMRC ~/.vimrc 

# run the plugin installs:
# see: http://stackoverflow.com/questions/12834370/run-vim-command-from-commandline
# note that we have to compile VimProc
echo Installing vim plugin-ins...
vim -e +PluginInstall +VimProcInstall +qall now

echo "install_gvim_and_plugins: done..."
