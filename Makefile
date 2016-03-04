.install: shell_tools.ind
	touch .install

.fully.prd: .minimally.prd .full_R.ind
	touch .fully.prd

.minimally.prd: science_stack.ind shell_tools.ind
	touch .minimally.prd

.science_stack.ind: docker.ind conda.ind base_R.ind:
	touch .science_stack.ind

.shell_tools.ind: packages.red zsh.ind vim.ind tmux.ind
	touch .shell_tools.ind

.full_R.ind: vimcom.ind r-dbi.ind
	touch .full_R.ind

.r-dbi.ind: base_R.ind
	zsh R/install_RMysql_RPostgres.zsh
	touch .r-dbi.ind

.vimcom.ind: base_R.ind
	zsh R/install_vimcom.zsh
	touch .vimcom.ind

.base_R.ind: conda.ind
	zsh R/install_R_package_dependencies.zsh
	touch .base_R.ind

.conda.ind: zsh.ind
	zsh misc/install_miniconda.zsh
	touch .conda.ind

.docker.ind: packages.red
	bash misc/install_docker.sh
	touch .docker.ind

.packages.red:
	bash misc/remove_translation_packages.sh
	touch .packages.red

.zsh.ind: packages.red
	bash zsh/install_git_and_zsh.sh
	touch .zsh.ind

.vim.ind: packages.red
	bash vim/install_gvim_and_plugins.sh
	touch .vim.ind

.tmux.ind: packages.red
	bash tmux/install_tmux_and_plugins.sh
	touch .tmux.ind

# use vagrant to test shell scripts -- set the recipe to a PHONY target
.PHONY: test-scripts 
test-scripts:
	vagrant destroy -f
	vagrant up --provision
	vagrant destroy -f

