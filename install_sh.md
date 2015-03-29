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
4. Calls
   [tmux/install_tmux_and_plugins.sh](tmux/install_tmux_and_plugins_sh.md).
5. Calls [R/update_ubuntu_R_repo.sh](R/update_ubuntu_R_repo.md) to 
   update the `R` CRAN deb repo and install the newest version of `r-base`.
