#!/bin/bash

echo "Installing libcurl4-openssl for devtools..."
sudo apt-get install -y libcurl4-openssl-dev 

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

echo "Setting up CA Certs for libcurl/devtools..."

# make sure the default CA bundle is available
CURL_CA_BUNDLE_DIR=/etc/pki/tls/certs
export CURL_CA_BUNDLE=$CURL_CA_BUNDLE_DIR/ca-bundle.pem

if [ ! -d $CURL_CA_BUNDLE_DIR ]; then
  sudo mkdir -p /etc/pki/tls/certs
fi
if [ ! -f $CURL_CA_BUNDLE ]; then
  sudo wget -O $CURL_CA_BUNDLE https://curl.haxx.se/ca/cacert.pem
fi

sudo ln -fs $CURL_CA_BUNDLE $CURL_CA_BUNDLE_DIR/ca-bundle.crt
sudo chown -R $(whoami) /etc/pki/tls/certs 

# setup R environment
echo "Creating conda-R environment..."
if [ "$SHELL" != '/usr/bin/zsh' ]; then
  source ~/.zshrc
fi

conda install -y --channel r \
  jupyter \
  r-irkernel \
  r-data.table \
  r-devtools \
  r-ggplot2 \
  r-stringr

echo "Installing packages with devtools..." 
cat > tmp.R <<EOT
options(unzip = 'internal',
        repos = c(CRAN = "https://cran.rstudio.com")); 
devtools::install_github(c("renkun-ken/pipeR")); 
EOT

Rscript tmp.R || \
  echo "One or more R packages failed to install..."

rm tmp.R

echo "install_R_package_dependencies.sh: done..."
