#!/bin/bash

# append U-Muenster CRAN mirror to DEBIAN repo list
echo "Adding U-Muenster CRAN mirror to debian repo list..."

DEB_SOURCE="/etc/apt/sources.list"
CRAN_DEB="deb http://cran.uni-muenster.de/bin/linux/ubuntu trusty/"

cp $DEB_SOURCE tmpDebSource
echo "# Add CRAN" >> tmpDebSource
echo $CRAN_DEB >> tmpDebSource
sudo mv tmpDebSource $DEB_SOURCE

# don't need to add GPG key for some reason...

echo "Updaing apt-get and (re)install r-base..."
sudo apt-get update
sudo apt-get install -y r-base
