#!/usr/bin/env zsh -i

echo "Installing packages with devtools..." 
cat > tmp.R <<EOT
options(unzip = 'internal',
        repos = c(CRAN = "https://cran.rstudio.com")); 
install.packages("setwidth");
devtools::install_github(c("jalvesaq/colorout"))
EOT

Rscript tmp.R
EXIT_CODE=$?  
rm tmp.R 

if [ ! $EXIT_CODE -eq 0 ]; then
  exit 1
fi
