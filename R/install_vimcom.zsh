#!/usr/bin/env zsh

echo "Installing headers for 'vimcom'..."
sudo apt-get install -y libx11-dev

echo "Installing packages with devtools..." 
cat > tmp.R <<EOT
options(unzip = 'internal',
        repos = c(CRAN = "https://cran.rstudio.com")); 
install.packages("setwidth");
devtools::install_github(c("jalvesaq/VimCom",
			   "jalvesaq/colorout"))
EOT
	
Rscript tmp.R
EXIT_CODE=$?  
rm tmp.R 

if [ ! $EXIT_CODE -eq 0 ]; then
  exit 1
fi
