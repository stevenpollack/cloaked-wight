.install: .shell_tools.ind
	touch .install

.fully.prd: .minimally.prd .full_R.ind
	touch .fully.prd

.minimally.prd: .shell_tools.ind .science_stack.ind
	touch .minimally.prd

.science_stack.ind: .conda.ind .base_R.ind .docker.ind
	touch .science_stack.ind

.shell_tools.ind: .packages.red .zsh.ind .nvim.ind .tmux.ind
	touch .shell_tools.ind

.full_R.ind: .devtools.ind .r-dbi.ind
	touch .full_R.ind

.r-dbi.ind: .base_R.ind
	exec /usr/bin/env zsh -i R/install_RMysql_RPostgres.zsh
	touch .r-dbi.ind

.devtools.ind: .base_R.ind
	exec /usr/bin/env zsh -i R/install_using_devtools.zsh
	touch .devtools.ind

.base_R.ind: .conda.ind
	./R/install_R_package_dependencies.sh
	./misc/setup_ca_certs.sh
	exec /usr/bin/env zsh -i R/setup_R_environment.zsh 
	touch .base_R.ind

.nvim.ind: .packages.red .conda.ind
	exec /usr/bin/env zsh -i neovim/install_neovim.zsh
	touch .nvim.ind 

.conda.ind: .zsh.ind
	exec /usr/bin/env zsh -i misc/install_miniconda.zsh
	touch .conda.ind

.nodejs.ind: .packages.red
	./misc/install_nodejs.sh
	touch .nodejs.ind

.docker.ind: .packages.red
	./misc/install_docker.sh
	touch .docker.ind

.zsh.ind: .packages.red
	./zsh/install_git_and_zsh.sh
	touch .zsh.ind

.tmux.ind: .packages.red
	./tmux/install_tmux_and_plugins.sh
	touch .tmux.ind

.packages.red:
	./misc/remove_translation_packages.sh
	touch .packages.red 

# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts clean container

container:
	docker build -t cloaked-wight .
	docker run -it cloaked-wight

test-scripts: clean
	vagrant destroy -f
	vagrant up 

clean:
	ls -a | grep '\.\(red\|ind\|prd\|install\)' | xargs rm || \
	  echo "all clean"
