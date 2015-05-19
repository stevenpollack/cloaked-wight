echo "Installing headers for 'XML', 'git2r' and 'RCurl'..."
sudo apt-get install -y libxml2-dev > /dev/null
sudo apt-get install -y libgit2-dev > /dev/null
sudo apt-get install -y libcurl4-openssl-dev > /dev/null

echo "Installing headers for 'RMySQL' and 'RPostgres'..."
sudo apt-get install -y libpq-dev > /dev/null
sudo apt-get install -y libmysqlclient-dev > /dev/null

echo "Installing 'devtools', 'data.table', 'ggplot2', 'reshape2', 'string', 'Rcpp', 'DBI', 'RMySQL', 'RPostgres'..."
INSTALL_SCRIPT='options(repos = c(CRAN = "http://cran.rstudio.com")); 
install.packages("devtools"); 
install.packages("data.table"); 
install.packages("ggplot2"); 
install.packages("reshape2"); 
install.packages("stringr"); 
devtools::install_github("RcppCore/Rcpp"); 
devtools::install_github("rstats-db/DBI"); 
devtools::install_github("rstats-db/RMySQL"); 
devtools::install_github("rstats-db/RPostgres");'

echo $INSTALL_SCRIPT >> tmp.R

sudo Rscript -e "source('tmp.R')"
rm tmp.R

echo "install_R_package_dependencies.sh finished. This does not mean that all packages were successfully installed, though..."
