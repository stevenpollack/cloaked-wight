[vimr-plugin](http://www.lepem.ufc.br/jaa/r-plugin.html)
======================

The actual plug-in installation is handled via [vundle](vundle.md). However, 
you'll still need to make sure your version of `vim` has `+clientserver` enabled
and that you have the necessary packages (see [R/Rprofile](../R/Rprofile.md)).

#### vim +clientserver
To see if you have `+clientserver`, check out the output to:
```
vim +version
``` 
If your version of vim does not have it, you'll probably want `gvim`.
On Ubuntu 12.04 there are multiple options
```
$ sudo apt-cache search gvim
# vim-gnome - Vi IMproved - enhanced vi editor - with GNOME2 GUI
# vim-athena - Vi IMproved - enhanced vi editor - with Athena GUI
# vim-gtk - Vi IMproved - enhanced vi editor - with GTK2 GUI
```
However, I usually just go with:
```
sudo apt get install vim-gnome
```
 
#### "extending" vimr-plugin
Though `vimr-plugin` has key bindings that call knitr (or Sweave), it
wasn't clear how to modify these to call `render` from the "rmarkdown"
`R` package (available on CRAN). 

The following snippet (from the `.vimrc`) maps `F2` to a routine that
calls  `rmarkdown::render` on your open buffer:
```VimL
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
```
Note that this mapping works regardless of the existence of `vimr-plugin`
so it's not an extenion of plug-in, so much as it's just a customized 
key mapping. 
