# cloaked-wight
Repo for my various profile and config files
******

Dependencies:

* (`sudo apt get`) tmux
* (`sudo apt get`) vim
  * vundle
  * you'll need `gvim` -- (`sudo apt-cache search gvim`)
    -- for `+clientserver` vim capabilities
* (`sudo apt get`) zsh
  * oh-my-zsh

_Note:_ `tmux/.tmux.conf` is based on pivotal's tmux config

* if using a linux desktop from crouton you'll need to change the
 [default locale of gnome-terminal](http://unix.stackexchange.com/questions/28136/set-gnome-terminals-default-charset-to-utf8):
```
gconftool --set --type=string /apps/gnome-terminal/profiles/Default/encoding en_US.UTF-8
```
* `vim-airline` uses the [powerline fonts](https://github.com/powerline/fonts):
you can install them into `~/.fonts/` and then
```
sudo fc-cache -fv ~/.fonts
```
To install them. This doesn't fix missing glyphs associated with the "amuse"
oh-my-zsh theme.

