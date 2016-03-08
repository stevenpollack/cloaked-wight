# aliases and exports to make sure that
# the tmux plugin starts the right tmux

# alias for starting tmux in -2
alias tmux="tmux -2" 

# default term to 256-color
export TERM='xterm-256color'

# have zsh start in a tmux session
export ZSH_TMUX_AUTOSTART=false

# alias for vim to nvim
alias vim="nvim"

alias sourceZshConfig="source ~/.zshrc"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to anaconda 
export ANACONDA=~/anaconda

# User configuration
export PATH="/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
export PATH=$ANACONDA/bin:$PATH 

export SHELL=$(which zsh)

# You may need to manually set your language environment (LOCALE)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set OS X specific options:
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Append TEXLIVE to path
  export TEXLIVE=/usr/local/texlive/2015basic/bin/x86_64-darwin
  export PATH=$TEXLIVE:$PATH
  # alias docker
  alias startDocker="bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="yes"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux sudo)

source $ZSH/oh-my-zsh.sh 
