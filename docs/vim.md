Dependencies
==============

### vim +clientserver
You'll need `vim` with `+clientserver` capabilities:
```
vim +version
``` 
will output a list of all the capabilities of your install. If
`+clientserver` isn't available, you'll 
```
sudo apt get install vim
```

But more importantly, you'll also need `vim` with `+clientserver`
capabilities; `gvim` comes stock with this. You can search for it
via
```
sudo apt-cache search gvim
```
But if your own ubuntu:
```
sudo apt get install ...
```
 

But packages are handled through `vundle`:
```
git clone ...
```

* (`sudo apt get`) vim
  * vundle
  * you'll need `gvim` -- (`sudo apt-cache search gvim`)
    -- for `+clientserver` vim capabilities
