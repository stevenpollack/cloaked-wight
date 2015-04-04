#!/bin/bash

echo "update_ubuntu_R_repo.sh: starting..."

# append U-Muenster CRAN mirror to DEBIAN repo list
echo "Adding U-Muenster CRAN mirror to debian repo list..."

DEB_SOURCE="/etc/apt/sources.list"
CRAN_DEB="deb http://cran.uni-muenster.de/bin/linux/ubuntu trusty/"

cp $DEB_SOURCE tmpDebSource
echo "# Add CRAN" >> tmpDebSource
echo $CRAN_DEB >> tmpDebSource
sudo mv tmpDebSource $DEB_SOURCE

# add GPG as per the instructions at #secure_apt in
# http://cran.r-project.org/bin/linux/ubuntu/
echo "Adding Michael Rutter's public key for CRAN secure apt..."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 > /dev/null

echo "Updating apt-get and (re)install r-base..."
sudo apt-get update > /dev/null
sudo apt-get install -y r-base > /dev/null

# print version number and location
R_VERSION=$(Rscript -e "cat(R.version.string, fill = TRUE)")
echo $R_VERSION installed to $(which R)

echo "update_ubuntu_R_repo.sh: done..."
