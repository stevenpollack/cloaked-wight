# default repo to rstudio AWS CRAN mirror:
options(repos=c(CRAN="https://cran.rstudio.com"))

# change default file download method
# in the case where R isn't built with
# proper libcurl support
if (capabilities("libcurl")) {
  options(download.file.method="libcurl")
} else {
 # if libcurl isn't available we want to set the download
 # method to:
 # OS X) 'curl'
 # linux) 'wget'
 
 sysname <- Sys.info()[['sysname']]

 if (grepl(x=sysname, pattern='darwin', ignore.case=TRUE)) {
   options(download.file.method="curl") 
 } else {
  options(download.file.method="wget") 
 }
}

if(interactive()){
  
  # Nvim-R plugin packages:
  require(colorout)
  require(setwidth)
  require(nvimcom)

  # workhorse packages:
  require(devtools)
  require(data.table)
  require(stringr)
  require(pipeR)
  require(ggplot2)

  # default errors to recover mode
  # options(error=utils::recover)

  # remember to set printout length
  options(max.print=200L)
}
