#!/bin/bash

##################
# NOTE:
# * THIS SCRIPT MUST BE CALLED FROM top-level of repo, OR tmux/ sub-dir
##################

echo "install_tmux_and_plugins.sh: starting..."

echo "Checking for tmux..."
tmux -V 2>&1 > /dev/null # suppress output
TMUX_IS_AVAILABLE=$?
if [ ! $TMUX_IS_AVAILABLE -eq 0 ]; then
  echo "tmux is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y tmux > /dev/null
else
  echo $(tmux -V) "is installed..." 
fi

# tmux (1.8) ships with ubuntu 14.04, so we just check the version 
# check for tmux v1.9a
echo "Checking tmux version..."
if [ $(tmux -V | grep -c "1.9") -eq 1 ]; then
  echo "tmux (>= 2.0) is installed."
else
  echo "Will install v2.0-1 now..."
  # sudo apt-get update
  sudo apt-get install -y python-software-properties software-properties-common > /dev/null
  sudo add-apt-repository -y ppa:pi-rho/dev > /dev/null
  sudo apt-get update > /dev/null
  sudo apt-get install -y tmux=2.0-1~ppa1~t > /dev/null
  if [ $(tmux -V | grep -c "2\\.0") -eq 0 ]; then
    echo "tmux 2.0-1 failed to install..."
    exit
  fi
fi

echo "Checking for xclip..."
xclip -version 2>&1 >/dev/null # suppress output
XCLIP_IS_AVAILABLE=$?
if [ ! $XCLIP_IS_AVAILABLE -eq 0 ]; then
  echo "xclip is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y xclip > /dev/null
else
  echo $(xclip -version) is installed to $(which xclip)
fi

# install TPM
echo "installing tmux plugin manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "creating .tmux.conf symlink..."
# this script is either being called from $cloaked-wight or
# $cloaked-wight/tmux
TMUXCONF=$(pwd)/tmux/.tmux.conf
if [ ! -f $TMUXCONF ]; then # we're being called from $cloaked-wight/vim
  TMUXCONF=$(pwd)/.tmux.conf
fi

if [ ! -f $TMUXCONF ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or tmux/ sub-dir"
  exit
fi

sudo ln -fs $TMUXCONF ~/.tmux.conf
echo Linked ~/.tmux.conf "->" $TMUXCONF ...

# from
# https://github.com/tmux-plugins/tpm/wiki/Installing-plugins-via-the-command-line-only
echo "installing tmux plugins..."
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required
tmux kill-server

echo "install_tmux_and_plugins.sh: done..."
