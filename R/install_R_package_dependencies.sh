#!/bin/bash

FAILED_LIBS=""
EXIT_CODE=0

echo "Installing headers for 'XML', 'git2r' and 'RCurl'..."
sudo apt-get install -y libxml2-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libxm2-dev");
  EXIT_CODE=1;
}

sudo apt-get install -y libcurl4-openssl-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libcurl4-openssl-dev");
  EXIT_CODE=1;
}

echo "Installing headers for 'RMySQL' and 'RPostgres'..."
sudo apt-get install -y libpq-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libpq-dev");
  EXIT_CODE=1;
}
 
sudo apt-get install -y libmysqlclient-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libmysqlclient-dev");
  EXIT_CODE=1;
}
 
echo "Installing headers for 'vimcom'..."
sudo apt-get install -y libx11-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libx11-dev");
  EXIT_CODE=1;
}
 

if [ $EXIT_CODE -eq 1 ]; then
  echo $FAILED_LIBS "failed to install..."
  exit $EXIT_CODE
fi

echo "creating .Rprofile symlink..."
# this script is either being called from $cloaked-wight or
# $cloaked-wight/R
RPROFILE=$(pwd)/R/.Rprofile
if [ ! -f $RPROFILE ]; then # we're being called from $cloaked-wight/vim
  RPROFILE=$(pwd)/.Rprofile
fi

if [ ! -f $RPROFILE ]; then # this is being called from someplace else!
  echo "must call script from repo top-level or R/ sub-dir"
  exit 1
fi

sudo ln -fs $RPROFILE ~/.Rprofile
echo Linked ~/.Rprofile "->" $RPROFILE ...
if [ ! -d ~/.Rpkgs ]; then
  mkdir ~/.Rpkgs # this is the new local library-site
fi

# setup R environment
#echo "Creating conda-R environment..."
#source ~/.zshrc
#conda install -y --channel r r-data.table r-devtools r-stringr

# make sure the default CA bundle is available
CA_BUNDLE_DIR=/etc/pki/tls/certs
CA_BUNDLE=$CA_BUNDLE_DIR/ca-bundle.pem
if [ ! -d $CA_BUNDLE_DIR ]; then
  mkdir -p /etc/pki/tls/certs
fi
if [ ! -f $CA_BUNDLE ]; then
  wget -O $CA_BUNDLE https://curl.haxx.se/ca/cacert.pem
fi

sudo ln -fs $CA_BUNDLE $CA_BUNDLE_DIR/ca-bundle.crt
sudo chown -R $(whoami) /etc/pki/tls/certs

#export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

echo "Installing packages with devtools..."
source ~/.zshrc

cat > tmp.R <<EOT
options(repos = c(CRAN = "https://cran.rstudio.com")); 
#install.packages(c("data.table", "devtools", "stringr"), quiet=TRUE);
devtools::install_github("RcppCore/Rcpp", quiet = FALSE); 
devtools::install_github("rstats-db/DBI", quiet = TRUE); 
devtools::install_github("rstats-db/RMySQL", quiet = TRUE); 
devtools::install_github("rstats-db/RPostgres", quiet = TRUE);
devtools::install_github("jalvesaq/VimCom", quiet = TRUE);
devtools::install_github("jalvesaq/colorout", quiet = TRUE);
install.packages("setwidth", quiet = TRUE);
devtools::install_github("renkun-ken/pipeR", quiet = TRUE);
EOT

R --file=tmp.R || {
  echo "One or more R packages failed to install...";
  EXIT_CODE=1;
}

#rm tmp.R

if [ $EXIT_CODE -eq 1 ]; then
  exit $EXIT_CODE
fi

echo "install_R_package_dependencies.sh: done..."
exit $EXIT_CODE
