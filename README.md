# cloaked-wight
Repo for my various profile and config files
******

[![Documentation Status](https://readthedocs.org/projects/cloaked-wight/badge/?version=latest)](https://readthedocs.org/projects/cloaked-wight/?badge=latest)
  
### Notes:  
* The full documentation is available as a 
  [Read The Docs Wiki](http://cloaked-wight.readthedocs.org/en/latest/)
* `tmux/.tmux.conf` is based on pivotal's tmux config + `tmux-yank`
* if using a linux desktop from crouton you'll need to change the
 [default locale of gnome-terminal](http://unix.stackexchange.com/questions/28136/set-gnome-terminals-default-charset-to-utf8):
```
gconftool --set --type=string /apps/gnome-terminal/profiles/Default/encoding en_US.UTF-8
```

### To do:
* write a script that installs the obvious/easy dependencies
* write a script to automatically make symlinks from `*/.*` to `~/.*`.
