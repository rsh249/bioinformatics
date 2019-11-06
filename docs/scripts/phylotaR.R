library(phylotaR)
#https://cran.r-project.org/web/packages/phylotaR/vignettes/phylotaR.html
wd <- getwd()
ncbi_dr <- '/usr/bin'
txid <- 9504
setup(wd = wd, txid = txid, ncbi_dr = ncbi_dr, v = TRUE)

run(wd = wd)