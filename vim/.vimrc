set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" Keep Plugin commands between vundle#begin/end.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive' " access git through vim command-line

" slimux plugin to make a python copy of vim-r
Plugin 'epeli/slimux'
" vim-jedi for python-related stuff
Plugin 'davidhalter/jedi-vim'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9' " this is a utility package, likely required by other plugins

" browse files intelligently, needs ruby-dev
Plugin 'wincent/command-t'  

" Get latest versions of Vim-R plugin and runtime files
" vim R-plugin
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'jalvesaq/R-Vim-runtime'
" powerline plugin
Plugin 'bling/vim-airline'

" tab completion
Plugin 'ervandew/supertab'

" color schemes:
" monokai
Plugin 'sickill/vim-monokai'
" vim-r-plugin
Plugin 'jalvesaq/southernlights'

" syntax highlighting
" markdown
Plugin 'tpope/vim-markdown' 

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

" turn off .swp files
set noswapfile

" turn on ruler at (soft) char limit
set ruler

" switch on row number
set number 

" enable 256-color support
set t_Co=256

if has("gui_running")
endif

" if PLUGIN_INSTALLATION is defined, it's because
" we're installing vim plugin's, and therefore
" southernlights doesn't exist. This will cause
" the provisioning to wait for ENTER or some other
" command... 
let s:plugin_installation = $PLUGIN_INSTALLATION

if ! s:plugin_installation
  " set color scheme
  syntax enable
  colorscheme southernlights
endif

unlet s:plugin_installation

" have r-plugin respect custom ~/.tmux.conf
let vimrplugin_notmuxconf = 1

" disable '_' -> '<-' mapping in r-plugin
let vimrplugin_underscore = 0
let vimrplugin_assign = 0

" start vimr R-session in vertical split
let vimrplugin_vsplit = 1
let vimrplugin_rconsole_width = 100

" start vimr highlighting for the following
" libraries:
let vimrplugin_start_libs = "base,stats,graphics,grDevices,utils,methods,data.table,stringr,devtools,magrittr,pipeR,ggplot2,reshape2"

" have VIM open R documentation in a new tab
let vimrplugin_vimpager = "tabnew"

" set mouse to allow for scrolling in TMUX
set mouse=a

" airline settings
" let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='simple'

" set tab to look like 2 space
set sw=2 " indent = 2 spacesd

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

" Show where the next pattern is as you type it
set incsearch

" have vimr-plugin call rmarkdown::render
function! RenderRMarkdown()
  " set autoread to supress W11 warning:
  " vim is going to complain about the rmd file already existing...
  :set autoread
  " get full file path via %:p
  ! Rscript -e "rmarkdown::render(commandArgs(TRUE)[2])" --args %:p
endfunction

" call RenderRMarkdown silently to suppress the "Press ENTER to continue" prompt
nnoremap <F2> :silent :call RenderRMarkdown() <CR>

" suggested slimux bindings
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

" command-t modifications:
" make <CR> (enter) open files in a new tab (as opposed to buffer)
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'
