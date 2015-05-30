
FAILED_LIBS=""
EXIT_CODE=0

echo "Installing headers for 'XML', 'git2r' and 'RCurl'..."
sudo apt-get install -y libxml2-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libxm2-dev");
  EXIT_CODE=1;
}

#sudo apt-get install -y libgit2-dev > /dev/null || {
#  FAILED_LIBS=$(echo $FAILED_LIBS "libgit2-dev");
#  EXIT_CODE=1;
#}

sudo apt-get install -y libcurl4-openssl-dev > /dev/null || {
  FAILED_LIBS=$(echo $FAILED_LIBS "libcurl4-openssl-dev");
  EXIT_CODE=1;
}

if [ $EXIT_CODE -eq 1 ]; then
  echo $FAILED_LIBS "failed to install..."
  exit $EXIT_CODE
fi

echo "Installing headers for 'RMySQL' and 'RPostgres'..."
sudo apt-get install -y libpq-dev > /dev/null
sudo apt-get install -y libmysqlclient-dev > /dev/null

echo "Installing headers for 'vimcom'..."
sudo apt-get install -y libx11-dev > /dev/null

echo "Installing 'devtools', 'data.table', 'ggplot2', 'reshape2', 'string', 'Rcpp', 'DBI', 'RMySQL', 'RPostgres', 'vimcom', 'colorout', 'setwidth'..."
INSTALL_SCRIPT='options(repos = c(CRAN = "http://cran.rstudio.com")); 
install.packages("devtools"); 
install.packages("stringr"); 
devtools::install_github("RcppCore/Rcpp"); 
install.packages("data.table"); 
install.packages("ggplot2"); 
install.packages("reshape2"); 
devtools::install_github("rstats-db/DBI"); 
devtools::install_github("rstats-db/RMySQL"); 
devtools::install_github("rstats-db/RPostgres");
devtools::install_github("jalvesaq/VimCom");
devtools::install_github("jalvesaq/colorout");
install.packages("setwidth");'

echo $INSTALL_SCRIPT >> tmp.R

sudo Rscript -e "source('tmp.R')" || {
  echo "One or more R packages failed to install...";
  EXIT_CODE=1;
}

rm tmp.R

if [ $EXIT_CODE -eq 1 ]; then
  exit $EXIT_CODE
fi

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

echo "install_R_package_dependencies.sh: done..."
exit $EXIT_CODE
