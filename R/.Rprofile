# default repo to rstudio AWS CRAN mirror:
options(repos = c(CRAN = "http://cran.rstudio.com"))

if(interactive()){
  # set installation to occur only when loading into an interactive session
  if (!require(devtools)) {
    utils::install.packages("devtools")
  }

  if (!require(vimcom)) {
    devtools::install_github("stevenpollack/vimcom")
    options(vimcom.verbose = 1)
  }

  if (!require(colorout)) {
    devtools::install_github("stevenpollack/colorout")
  }

  if (!require(setwidth)) {
    utils::install.packages("setwidth")
  }

  # default errors to recover mode
  options(error = utils::recover)
  # remember to set printout length and devtools shit
  options(max.print = 200L)
}
