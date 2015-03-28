## tmux-yank
To get tmux to copy to the clipboard, you'll want to use the tmux plugin:
`tmux-yank`. This requires

* [tmux (>=  1.9)](http://stackoverflow.com/questions/25940944/ugrade-tmux-from-1-8-to-1-9-on-ubuntu-14-04)
* [tmux plugin manager (TPM)](https://github.com/tmux-plugins/tpm)
* `xclip` (or `xsel`):

#### tmux 1.9a
Currently, the link above install `tmux` v1.9a, and this is only partially
stable. Occasionally, activating `vimr-plugin` when the first opened file
is _NOT_ an .R leads to a segfault...

#### TPM
Check the repo readme for the most up-to-date installation instructions.
As of 28-03-2015, you simply clone the repo, as below, and start `tmux`:
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### xclip
Easiest step in the whole recipe. If ``` which xclip ``` yields noting:
```
sudo apt-get install xclip
```

#### Putting it all together
`TPM` installs / reloads plugins based on the `^ I` `tmux` key-binding.
For my current `.tmux.conf`, `^` is bound to `CTRL + B` (or in vim parlance
`<C-B>`).

