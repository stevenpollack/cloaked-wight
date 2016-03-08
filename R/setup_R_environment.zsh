#!/usr/bin/env zsh

# setup R environment
echo "Creating conda-R environment..."

conda install -y --channel r \
  gcc \
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

Rscript tmp.R 
EXIT_CODE=$?  
rm tmp.R 

if [ ! $EXIT_CODE -eq 0 ]; then
  exit 1
fi

