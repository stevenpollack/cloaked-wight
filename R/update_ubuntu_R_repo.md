On Ubuntu 14.04, the default CRAN deb repository is slightly
out of sync with CRAN. To keep `R` as up to date as possible,
we need to modify
```
/etc/apt/sources.list
```
with something like
```
deb http://cran.uni-muenster.de/bin/linux/ubuntu trusty/
```
where the `cran.uni-muenster.de` part can be replaced with
any legit CRAN mirror.

Normally the procedure is

1. update `/etc/apt/sources.list`
2. `sudo apt-get update`
3. `sudo apt-get install -y r-base`

However, sometimes step #2 fails to integrate the new CRAN deb repo,
since public keys for the repo are not automatically available...
