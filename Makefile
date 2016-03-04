.install: .shell_tools.ind
	touch .install

.fully.prd: .minimally.prd .full_R.ind
	touch .fully.prd

.minimally.prd: .science_stack.ind .shell_tools.ind
	touch .minimally.prd

.science_stack.ind: .docker.ind .conda.ind .base_R.ind
	touch .science_stack.ind

.shell_tools.ind: .packages.red .zsh.ind .vim.ind .tmux.ind
	touch .shell_tools.ind

.full_R.ind: .vimcom.ind .r-dbi.ind
	touch .full_R.ind

.r-dbi.ind: .base_R.ind
	./R/install_RMysql_RPostgres.zsh
	touch .r-dbi.ind

.vimcom.ind: .base_R.ind
	./R/install_vimcom.zsh
	touch .vimcom.ind

.base_R.ind: .conda.ind
	./R/install_R_package_dependencies.zsh
	./misc/setup_ca_certs.sh
	./R/setup_R_environment.zsh
	touch .base_R.ind

.conda.ind: .zsh.ind
	./misc/install_miniconda.zsh
	touch .conda.ind

.docker.ind: .packages.red
	./misc/install_docker.sh
	touch .docker.ind

.packages.red:
	./misc/remove_translation_packages.sh
	touch .packages.red

.zsh.ind: .packages.red
	./zsh/install_git_and_zsh.sh
	touch .zsh.ind

.vim.ind: .packages.red
	./vim/install_gvim_and_plugins.sh
	touch .vim.ind

.tmux.ind: .packages.red
	./tmux/install_tmux_and_plugins.sh
	touch .tmux.ind

# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts clean
test-scripts: clean
	vagrant destroy -f
	vagrant up 

clean:
	ls -a | grep '\.\(red\|ind\|prd\|install\)' | xargs rm || \
	  echo "all clean"
