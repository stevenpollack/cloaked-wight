set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" monokai color scheme
Plugin 'sickill/vim-monokai'

" pivotal's TMUX conf
Plugin 'pivotal/tmux-config'

" markdown syntax highlighting
Plugin 'tpope/vim-markdown'

" vim R-plugin
Plugin 'vim-scripts/Vim-R-plugin'

" suggested color scheme: http://www.vim.org/scripts/script.php?script_id=3292
Plugin 'stevenpollack/vim-southernlights'

" powerline plugin
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" enable 256-color support
set t_Co=256

" set color scheme
syntax enable
colorscheme southernlights

" disable '_' -> '<-' mapping in r-plugin
let vimrplugin_underscore = 0

" have VIM open R documentation in a new tab
let vimrplugin_vimpager = "tabnew"

" set mouse to allow for scrolling in TMUX
set mouse=a

" airline settings
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='simple'

" wrap at 80 chars
set wrap
set textwidth=80 " sets hard wrapping at 80 chars
set wrapmargin=0 " wraps according to terminal size
set fo+=t " toggles wrapping on

" highlight characters past the 74th column
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%74v.*/
augroup END
