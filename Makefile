
# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts

test-scripts:
	vagrant destroy -f
	vagrant up --provision
	vagrant destroy -f

# remove translational packages
.PHONY: remove-translation-packages

remove-translation-packages:
	sudo sh ./remove_translation_packages.sh

# install just git and (oh my) zsh
.PHONY: git-and-zsh

git-and-zsh:
	sudo sh ./zsh/install_git_and_zsh.sh

# make symlinks in batches
.PHONY: create-symlinks

CURRENT_DIR=`pwd`

create-symlinks:
	sudo ln -fs $(CURRENT_DIR)/zsh/.zshrc  ~/.zshrc
	sudo ln -fs $(CURRENT_DIR)/tmux/.tmux.conf ~/.tmux.conf
	sudo ln -fs $(CURRENT_DIR)/R/.Rprofile ~/.Rprofile
	sudo ln -fs $(CURRENT_DIR)/vim/.vimrc ~/.vimrc
