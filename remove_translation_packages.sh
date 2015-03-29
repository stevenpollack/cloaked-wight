#!/bin/bash

# https://medoix.com/2012/01/22/disable-translation-packages-in-ubuntu/# search for Acquire::Languages "none" and append if it isn't there
TRANS_FILE="/etc/apt/apt.conf.d/99translations"
ACQUIRE_STR='Acquire::Languages "none";'

echo "Cleaning up translational packages..."
echo "Checking for" $TRANS_FILE "..."
if [ -e $TRANS_FILE ]; then
  # trans_file exists, and we check for acquire_str
  if [ $(grep -c $ACQUIRE_STR -F $TRANS_FILE) -eq 0 ]; then
    # modify a temporary copy of the translation file
    # and then copy it back into /etc/apt/apt.conf.d/
    cp $TRANS_FILE tmpTrans
    echo $ACQUIRE_STR >> tmpTrans
    sudo cp tmpTrans $TRANS_FILE
    rm tmpTrans
  fi
else 
  # trans_file does not exist
  echo $ACQUIRE_STR > tmpTrans
  sudo cp tmpTrans $TRANS_FILE
  rm tmpTrans
fi

# empty Translation packages from /var/lib/apt/lists/ directory and repopulate
TRANSLATION_PACKAGE_DIR="/var/lib/apt/lists"
echo "Removing all packages in" \
  $TRANSLATION_PACKAGE_DIR \
  "which grep with '*_Translation*'..."

find $TRANSLATION_PACKAGE_DIR -type f -name "*_Translation*" | \
  sudo xargs rm

sudo apt-get update

