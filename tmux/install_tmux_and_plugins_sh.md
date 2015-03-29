Since `tmux-yank` requires `tmux` (>= 1.9), TPM, and `xclip` (see
[tmux/tmux-yank](tmux-yank.md)) this script

1. Checks the version of `tmux` installed, and installs 1.9a from the `pi-rho` PPA
   according to [these directions](http://stackoverflow.com/questions/25940944/ugrade-tmux-from-1-8-to-1-9-on-ubuntu-14-04).
2. Installs [tmux plugin manager (TPM)](https://github.com/tmux-plugins/tpm).
3. Checks for and installs `xclip` (if missing).
4. Creates symlink between `~/.tmux.conf` and `tmux/.tmux.conf`.
5. Installs TPM plugins accoring to the TPM Wiki post on
[how to install plugins from command line](https://github.com/tmux-plugins/tpm/wiki/Installing-plugins-via-the-command-line-only).
