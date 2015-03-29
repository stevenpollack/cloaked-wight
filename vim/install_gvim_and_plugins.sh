# check for gvim and install
echo "checking... gvim"
if [ $(which gvim | grep -c "not found") -eq 1 ]; then
  echo "gvim is missing. Will sudo apt-get install now..."
  sudo apt-get install -y vim-gnome
else
  echo "gvim is installed."
fi

# install vundle
echo "installing vundle..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install powerline fonts for vim-airline
git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
sudo ~/.powerline_fonts/install.sh

# make symlink to vim/.vimrc
echo "making symlink to vim/.vimrc..."

# this script is either being called from $cloaked-wight or
# $cloaked-wight/vim
VIMRC=$(pwd)/vim/.vimrc
if [ ! -f $VIMRC ]; then # we're being called from $cloaked-wight/vim
  VIMRC=$(pwd)/.vimrc
fi

if [! -f $VIMRC ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or vim/ sub-dir"
  exit
fi

sudo ln -s VIMRC ~/.vimrc

# run the plugin installs
# see: http://stackoverflow.com/questions/12834370/run-vim-command-from-commandline
vim +PluginInstall +qall now

