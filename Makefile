
# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts

test-scripts:
	vagrant destroy -f
	vagrant up --provision
	vagrant destroy -f

# make symlinks in batches
# TODO: figure out how to properly build these with dependencies
.PHONY: create-symlinks

CURRENT_DIR=`pwd`

create-symlinks:
	sudo ln -fs $(CURRENT_DIR)/zsh/.zshrc  ~/.zshrc
	sudo ln -fs $(CURRENT_DIR)/tmux/.tmux.conf ~/.tmux.conf
	sudo ln -fs $(CURRENT_DIR)/R/.Rprofile ~/.Rprofile
	sudo ln -fs $(CURRENT_DIR)/vim/.vimrc ~/.vimrc
