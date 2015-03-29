#!/bin/bash

# check for tmux v1.9a
echo "checking... tmux"
if [ $(tmux -V | grep -c "1.9") -eq 1 ]; then
  echo "tmux (>= 1.9) is installed."
else
  echo "tmux is either uninstalled or the wrong version." \ 
  "Will install v1.9a now..."
  sudo apt-get update
  sudo apt-get install -y python-software-properties software-properties-common
  sudo add-apt-repository -y ppa:pi-rho/dev
  sudo apt-get update
  sudo apt-get install -y tmux=1.9a-1~ppa1~t
  if [ $(tmux -V | grep -c "1.9") -eq 0 ]; then
    echo "tmux 1.9a failed to install."
    exit
  fi
fi

# install TPM
echo "installing tmux plugin manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "checking... xclip"
if [ $(which xclip | grep -c "not found") -eq 1 ]; then
  echo "xclip is missing. Will sudo apt-get install now..."
  sudo apt-get install -y xclip
else
  echo "xclip is installed."
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
