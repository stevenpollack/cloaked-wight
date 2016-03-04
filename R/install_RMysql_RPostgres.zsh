#!/usr/bin/env zsh

echo "Installing headers for 'RMySQL' and 'RPostgres'..."
sudo apt-get install -y \
  libmysqlclient-dev \
  libpq-dev \
  pkg-config

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

rm tmp.R 
