This shell script is meant to be run after you've cloned `cloaked-wight`,
most preferably on a fresh Ubuntu 14.04 installation.

It does the following:

1. Removes any translational packages from `apt` (speeding up `apt-get *`
   commands).
2. Checks for `zsh` and `sudo apt-get install -y zsh` if it cannot find it.
3. Checks for `gvim` (since this `.vimrc` installs `vimr-plugin` which depends
   on certain `vim` capabilities that are necessarily installed with `gvim`. If
   it cannot find `gvim`, then `sudo apt-get install -y vim-gnome` is used to install
   it.
4. Checks for `tmux` version 1.9. If `tmux` doesn't exist, or is of a different
   version, [these directions](http://stackoverflow.com/questions/25940944/ugrade-tmux-from-1-8-to-1-9-on-ubuntu-14-04))
   are followed and the `pi-rho/dev` PPA is added
   via `sudo add-apt-repository -y ppa:pi-rho/dev` wherefrom `tmux` 1.9a is
   installed.
5. Calls [R/update_ubuntu_R_repo.sh](R/update_ubuntu_R_repo.md) to 
   update the `R` CRAN deb repo and install the newest version of `r-base`.
