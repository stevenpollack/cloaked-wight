# cloaked-wight
Repo for my various profile and config files
******

[![Build Status](https://travis-ci.org/stevenpollack/cloaked-wight.svg?branch=master)](https://travis-ci.org/stevenpollack/cloaked-wight)
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
* if using ubuntu from a lenovo (e.g. ideapad), follow
[these
instructions](http://askubuntu.com/questions/262003/how-do-i-get-brightness-working-on-a-lenovo-ideapad-yoga)
to restore functionality to the brightness button. In particular,
modify the `_DEFAULT` value in `/etc/default/grub` and add
`blacklist lenovo_laptop` to the blacklisted hardware (see accepted answer).

### Testing:
* Install scripts are tested using
  [vagrant](http://www.vagrantup.com/downloads) and
  [virtualbox](https://www.virtualbox.org/wiki/Downloads) -- you may need to
  make sure that hardware acceleration is enabled in your system's BIOS if you
  find that you cannot virtualize 64-bit Ubuntu...
* The repo vagrant file, `Vagrantfile`, has all the provisions set up so that
  you, too, can verify that the tests exist, simply invoke `vangrant up` at 
  the top-level of the repo.

