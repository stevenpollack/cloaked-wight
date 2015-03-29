This script does the following:

1. Checks for `gvim` and installs `vim-gnome` if it's missing.
2. Installs [vundle](https://github.com/gmarik/Vundle.vim).
3. Clones the [powerline fonts](https://github.com/powerline/fonts) into `~/.powerline_fonts` and installs via the repository `install.sh`.
4. Makes a symlink between `vim/.vimrc` and `~/.vimrc`.
5. Run's `vim +PluginInstall +qall now` (see [stackoverflow](http://stackoverflow.com/questions/12834370/run-vim-command-from-commandline)) to have vundle
   install all plugins in `.vimrc`. 
