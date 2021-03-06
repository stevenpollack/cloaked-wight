#!/bin/sh

echo "install_git_and_zsh.sh: starting..."
echo "Checking for git..."
git --version 2>&1 >/dev/null # suppress output
GIT_IS_AVAILABLE=$?
if [ ! $GIT_IS_AVAILABLE -eq 0 ]; then
  echo "git is missing. Will sudo apt-get install now..."
  sudo apt-get install -y git > /dev/null
fi

echo $(git --version) is installed at $(which git)

echo "Checking for zsh..."
zsh --version 2>&1 >/dev/null
ZSH_IS_AVAILABLE=$?
if [ ! $ZSH_IS_AVAILABLE -eq 0 ]; then
  echo "zsh is missing. Will sudo apt-get install now..."
  sudo apt-get install -y zsh > /dev/null
fi

echo $(zsh --version) is installed at $(which zsh)

echo "Checking for oh-my-zsh..."
OH_MY_ZSH_DIR="~/.oh-my-zsh"
if [ ! -d $OH_MY_ZSH_DIR ]; then
  echo $OH_MY_ZSH_DIR "is not present... Will install via wget..."
  sudo wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
fi

# copy over .zshrc 
echo "Creating .zshrc symlink..."
# this script is either being called from $cloaked-wight or
# $cloaked-wight/tmux
ZSHRC=$(pwd)/zsh/.zshrc
ZSH_THEME=$(pwd)/zsh/yes.zsh-theme

if [ ! -f $ZSHRC ]; then # we're being called from $cloaked-wight/vim
  ZSHRC=$(pwd)/.zshrc
  ZSH_THEME=$(pwd)/zsh/yes.zsh-theme
fi

if [ ! -f $ZSHRC ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or zsh/ sub-dir"
  exit
fi

echo "Linking ~/.zshrc ->" $ZSHRC ...
ln -fs $ZSHRC ~/.zshrc

echo "Copying yes.zsh-theme in ~/.oh-my-zsh/themes..."
cp $ZSH_THEME ~/.oh-my-zsh/themes/

# change shell to zsh
sudo chsh -s $(which zsh) $(whoami)
echo "Changed default shell to zsh..."

echo "install_git_and_zsh.sh: done..."
