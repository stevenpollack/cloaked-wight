If using `R` interactively, packages "colorout", "setwidth" and "vimcom" will
be loaded (these are set in the `.Rprofile`). 

### vimcom and colorout
The "[vimcom](http://www.lepem.ufc.br/jaa/vimcom.html)" package is
absolutely necessary for `vimr-plugin`, while
"[colorout](http://www.lepem.ufc.br/jaa/colorout.html)"
is only recommended; however neither are available on CRAN, so installing them
(from inside `R`) is done by download `.tar.gz`'s:

#### vimcom installation
```R
download.file("http://www.lepem.ufc.br/jaa/vimcom_1.2-2.tar.gz",
              destfile = "vimcom_1.2-2.tar.gz")
install.packages("vimcom_1.2-2.tar.gz",
                 type = "source",
                 repos = NULL)
```

If "vimcom" fails to install, it's probably because you don't have `X11`:
```
sudo apt-get install libx11-dev
```

#### colorout installation
```R
download.file("http://www.lepem.ufc.br/jaa/colorout_1.1-0.tar.gz",
	      destfile = "colorout_1.1-0.tar.gz")
install.packages("colorout_1.1-0.tar.gz",
		  type = "source",
		  repos = NULL)
```

#### setwidth installation
"setwidth" is CRAN-available, so you can get it in the usual way
```R
install.packages("setwidth")
```

