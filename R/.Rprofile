# default repo to rstudio AWS CRAN mirror:
options(repos = c(CRAN = "http://cran.rstudio.com"))

# set default library location to ~/.Rpkgs
.libPaths("~/.Rpkgs")

if(interactive()){
  
  # vim-r-plugin packages:
  require(colorout)
  require(setwidth)
  options(vimcom.verbose = 1) # optional
  require(vimcom)

  # workhorse packages:
  require(devtools)
  require(data.table)
  require(stringr)
  require(pipeR)
  require(ggplot2)

  # default errors to recover mode
  # options(error = utils::recover)

  # remember to set printout length
  options(max.print = 200L)
}
