" neovim vim: set sw=4:

"""""""""""""""""""""""""""""""""""""
" plugin-independent editor settings
"""""""""""""""""""""""""""""""""""""

"set nocompatible              " be iMproved, required
"filetype off                  " required

" turn off .swp files
set noswapfile

" turn on ruler at (soft) char limit
set ruler

" switch on row number
set number 

" enable 256-color support
set t_Co=256

syntax enable

" buffer mappings
map gt :bn<CR>
map gT :bp<CR>

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" set mouse to allow for scrolling in TMUX
set mouse=a

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

"""""""""""""""""""""""""""
" plugin-depedent settings
"""""""""""""""""""""""""""

" auto-install vim-plug if it's not available
" vim-plug 
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

try
    call plug#begin()
    " vim-git wrapper
    Plug 'tpope/vim-fugitive'
     
    " vim-jedi for python-related stuff
    Plug 'davidhalter/jedi-vim'

    " plugin from http://vim-scripts.org/vim/scripts.html
    " this is a utility package, likely required by other plugins
    Plug 'vim-scripts/L9' 

    " browse files intelligently with unite: requires vimproc
    " unit pre-req, needs to be installed via `VimProcInstall`
    Plug 'Shougo/vimproc.vim' 
    Plug 'Shougo/unite.vim'

    " getting punched in the face is no way to tango:
    " vim-bbye stops :bdelete from nuking (v|h)splits
    Plug 'moll/vim-bbye'

    " Get latest versions of Vim-R plugin and runtime files
    Plug 'jalvesaq/Nvim-R'

    " airline plugin + themes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " tab completion
    Plug 'ervandew/supertab'

    " color schemes: monokai, southern lights
    Plug 'sickill/vim-monokai'
    Plug 'jalvesaq/southernlights'
    Plug 'kristijanhusak/vim-hybrid-material'

    " syntax highlighting
    " markdown
    " Docker
    Plug 'tpope/vim-markdown' 
    Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

    call plug#end()
    
    if isdirectory(g:plugs['vim-hybrid-material'].dir)
	set background=dark
	colorscheme hybrid_reverse
    endif

    " use vim-bbye to close buffers
    if isdirectory(g:plugs['vim-bbye'].dir)
	map gq :Bdelete<CR> 
	" close all open buffers
	map gqa :bufdo :Bdelete<CR> 
    endif

    " configure nvimcom if installed
    if isdirectory(g:plugs['Nvim-R'].dir)
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
	let vimrplugin_start_libs = "base,stats,graphics,grDevices,utils,methods,data.table,stringr,devtools,pipeR,ggplot2"

	" have VIM open R documentation in a horizontal split
	" let vimrplugin_vimpager = "horizontal"
    endif

    " airline settings
    if isdirectory(g:plugs['vim-airline'].dir)
	"let g:airline_symbols = {}
	"let g:airline_symbols.space = ' '
	set laststatus=2
	let g:airline_theme='hybridline'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1 
    endif

    " Unite -- configure if installed:
    if isdirectory(g:plugs['unite.vim'].dir)
	let g:unite_source_history_yank_enable = 1 
	" set filtration to fuzzy matching
	call unite#filters#matcher_default#use(['matcher_fuzzy'])

	nnoremap <leader>t :<C-u>Unite -ignorecase -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
	nnoremap <leader>b :<C-u>Unite -ignorecase -no-split -buffer-name=buffer  buffer<cr>
	nnoremap <leader>/ :<C-u>Unite -no-split -buffer-name=files -start-insert grep<cr>
	" nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
	nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
	nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>

	" Custom mappings for the unite buffer
	autocmd FileType unite call s:unite_settings()
	function! s:unite_settings()
	    " Play nice with supertab
	    let b:SuperTabDisabled=1
	    " Enable navigation with control-j and control-k in insert mode
	    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
	    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
	endfunction

	" Use ag for search
	if executable('ag')
	    let g:unite_source_grep_command = 'ag'
	    let g:unite_source_grep_default_opts = '-i --nogroup --nocolor'
	    let g:unite_source_grep_recursive_opt = ''
	endif 

    endif
    
catch
endtry 
