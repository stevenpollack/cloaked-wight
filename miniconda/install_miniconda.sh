#!/usr/bin/zsh

# install anaconda
miniconda=Miniconda3-latest-Linux-x86_64.sh
anaconda_dir=~/anaconda
anaconda_bin=$anaconda_dir/bin

if [ ! -e $miniconda ]; then
  wget http://repo.continuum.io/miniconda/$miniconda
fi

chmod +x $miniconda
bash $miniconda -b -p $anaconda_dir 

# add anaconda bin to zshrc and export it for future scripts
cat >> ~/.zshrc << END

# add for anaconda install
export PATH=$anaconda_bin:\$PATH 
END

export PATH=$anaconda_bin:$PATH

