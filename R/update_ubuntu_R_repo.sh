#!/bin/bash

echo "update_ubuntu_R_repo.sh: starting..."

# append U-Muenster CRAN mirror to DEBIAN repo list
echo "Adding U-Muenster CRAN mirror to debian repo list..."

# get ubuntu version so we can figure out which repo to add
UBUNTU_VERSION=$(lsb_release -c | sed -e 's/Codename:\s*//g')

DEB_SOURCE="/etc/apt/sources.list"
CRAN_DEB=$(echo "deb http://cran.uni-muenster.de/bin/linux/ubuntu" $UBUNTU_VERSION"/")

cp $DEB_SOURCE tmpDebSource
echo "# Add CRAN" >> tmpDebSource
echo $CRAN_DEB >> tmpDebSource
sudo mv tmpDebSource $DEB_SOURCE

# add GPG as per the instructions at #secure_apt in
# http://cran.r-project.org/bin/linux/ubuntu/
echo "Adding Michael Rutter's public key for CRAN secure apt..."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 > /dev/null

EXIT_CODE=0

echo "Updating apt-get and (re)install r-base..."
sudo apt-get update > /dev/null
sudo apt-get install -y r-base > /dev/null || {
  echo "r-base failed to install...";
  EXIT_CODE=1;
}

if [ $EXIT_CODE -eq 1 ]; then
  exit $EXIT_CODE
fi

# print version number and location
R_VERSION=$(Rscript -e "cat(R.version.string, fill = TRUE)")
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo $R_VERSION installed to $(which R)
fi

echo "update_ubuntu_R_repo.sh: done..."
exit $EXIT_CODE
