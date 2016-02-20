#!/bin/bash

##################
# NOTE:
# * THIS SCRIPT MUST BE CALLED FROM top-level of repo, OR tmux/ sub-dir
##################

echo "install_tmux_and_plugins.sh: starting..."

# helper functions:
install_tmux()
{
  # add pi-rho/dev PPA for latest version of tmux
  sudo apt-get install -y python-software-properties software-properties-common > /dev/null
  sudo add-apt-repository -y ppa:pi-rho/dev > /dev/null
  sudo apt-get update > /dev/null

  TMUX_VERSION=2.0-1~ppa1~$1

  sudo apt-get install -y tmux=$TMUX_VERSION > /dev/null
  if [ $(tmux -V | grep -c "2\\.0") -eq 0 ]; then
    echo "tmux 2.0-1 failed to install..."
    exit 1
  fi
}

check_tmux_version()
{
  tmux -V 2>&1 > /dev/null # suppress output
  TMUX_IS_AVAILABLE=$?

  if [ $TMUX_IS_AVAILABLE -eq 0 ]; then
    export TMUX_VERSION=$(tmux -V | sed -e 's/tmux\s*//g')
    echo $(Rscript -e 'cat(Sys.getenv("TMUX_VERSION") > "1.9")')
  else
    echo "FALSE"
  fi
}

echo "Checking for tmux..."
tmux -V 2>&1 > /dev/null # suppress output
TMUX_IS_AVAILABLE=$?

# get ubuntu version in the case we need to install or upgrade tmux
# this is actually the first letter of the version name. E.g.,
# if version is Trusty, $UBUNTU_VERSION='t'.
UBUNTU_VERSION=$(lsb_release -c | sed -e 's/Codename:\s*\(\w\)\w*/\1/g')
#UBUNTU_VERSION=$(lsb_release -c | sed -e 's/Codename:\s*//g')

VERSION_IS_GOOD=$(check_tmux_version)

if [ ! "$VERSION_IS_GOOD" = "TRUE" ]; then
  if [ ! "$UBUNTU_VERSION" = "w" ]; then
    echo "Installig the latest version of tmux in pi-rho PPA..."
    install_tmux $UBUNTU_VERSION
    VERSION_IS_GOOD=$(check_tmux_version)
  else
    echo "Installing latest version of tmux via apt-get..."
    sudo apt-get install -y tmux > /dev/null
  fi
fi

# double check that everything got installed properly
if [ ! "$VERSION_IS_GOOD" = "TRUE" ]; then
  echo "Latest version of tmux failed to properly install..."
  exit 1
fi

echo "Checking for xclip..."
xclip -version 2>&1 >/dev/null # suppress output
XCLIP_IS_AVAILABLE=$?
if [ ! $XCLIP_IS_AVAILABLE -eq 0 ]; then
  echo "xclip is not installed... Will get with sudo apt-get..."
  sudo apt-get install -y xclip > /dev/null || {
  echo "xclip failed to install...";
  exit 1;
  } 
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
  exit 1
fi

sudo ln -fs $TMUXCONF ~/.tmux.conf
if [ $? -eq 0 ]; then
echo Linked ~/.tmux.conf "->" $TMUXCONF ...
else
  echo "Failed to create symlink between ~/.tmux.conf and" $TMUXCONF
  exit 1
fi

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
exit
