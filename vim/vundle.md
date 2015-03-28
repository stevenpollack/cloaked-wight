## vundle: a vim plug-in manager

[`vundle`](https://github.com/gmarik/Vundle.vim) is used to
handle the package management for the `.vimrc` file in this
repo. An example snippet which uses `vundle`:
```VimL
" vim R-plugin
Plugin 'vim-scripts/Vim-R-plugin'

" suggested color scheme: http://www.vim.org/scripts/script.php?script_id=3292
Plugin 'stevenpollack/vim-southernlights'

" powerline plugin
Plugin 'bling/vim-airline' 
```

See `~/.vimrc` for more examples and further explanation.

### Installation and usage
`vundle` is undergoing major changes, but currently, its only
major dependency is curl, and its installation is fairly 
straightforward:
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

To reload or (re)install plugins, you use the `:PluginInstall` command in `vim`
or, from the terminal,
```
vim +PluginInstall
```
 

