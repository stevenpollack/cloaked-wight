#!/bin/bash

# install anaconda
miniconda=Miniconda3-latest-Linux-x86_64.sh
anaconda_dir=/opt/anaconda
anaconda_bin=$anaconda_dir/bin

if [[ ! -f $miniconda ]]; then
  wget --quiet http://repo.continuum.io/miniconda/$miniconda
fi

chmod +x $miniconda
$miniconda -b -p $anaconda_dir 

cat >> ~/.zshrc << END
# add for anaconda install
export PATH=$anaconda_bin:\$PATH

END
