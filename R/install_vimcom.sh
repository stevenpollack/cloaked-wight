#!/bin/bash

echo "Installing headers for 'vimcom'..."
sudo apt-get install -y libx11-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libx11-dev");
  EXIT_CODE=1;
}

echo "Installing packages with devtools..." 
cat > tmp.R <<EOT
options(unzip = 'internal',
        repos = c(CRAN = "https://cran.rstudio.com")); 
install.packages("setwidth");
devtools::install_github(c("jalvesaq/VimCom",
			   "jalvesaq/colorout"))
EOT
	
Rscript tmp.R

rm tmp.R 
