#!/usr/bin/env zsh

echo "Installing headers for RMySQL, RPostgres and Rcpp..."
sudo apt-get install -y \
  libmysqlclient-dev \
  libpq-dev \
  pkg-config

# setup OS level IF statement
# update gmp to 6.0.0a
conda install -y -c https://conda.anaconda.org/ostrokach gmp 
# link /usr/lib/.../libgmp.so to anaconda's version:
ln -fs $ANACONDA/lib/libgmp.so.10 \
  /usr/lib/x86_64-linux-gnu/libgmp.so.10

echo "Installing packages with devtools..." 
cat > tmp.R <<EOT
options(unzip = 'internal',
        repos = c(CRAN = "https://cran.rstudio.com")); 
devtools::install_github(c("RcppCore/Rcpp",
			   "rstats-db/DBI",
			   "rstats-db/RMySQL",
			   "rstats-db/RPostgres"));
EOT

Rscript tmp.R 
EXIT_CODE=$?  
rm tmp.R 

if [ ! $EXIT_CODE -eq 0 ]; then
  exit 1
fi
