# R_script

# Installation
- R, Rtools, (RStudio) and RStan
- (Installation on Windows10)
- (Edit: 18/Feb/2023)

## R (https://cran.ism.ac.jp/bin/windows/base/old/4.1.3/ from https://cran.ism.ac.jp/)
1. R-4.1.3-win.exe

## Rtools (https://cran.ism.ac.jp/)
1. Rtools -> RTools 4.0 -> rtools40-x86_64.exe

## RStudio (https://posit.co/download/rstudio-desktop/)
1. Windows 10/11 RSTUDIO-2022.12.0-353.EXE
2. RStudio-2022.12.0-353.exe

## RStan (on R x64 4.1.3 or on RStudio)
1. install.packages('rstan', repos='https://cloud.r-project.org/', dependencies=TRUE)
2. pkgbuild::has_build_tools(debug = TRUE)
3. library(rstan)

## GGMCMC (on R x64 4.1.3 or on RStudio)
1. install.packages("ggmcmc", dependencies=TRUE)
2. pkgbuild::has_build_tools(debug = TRUE)
3. library(ggmcmc)

## dlm
1. install.packages("dlm", dependencies=TRUE)

## dlm
1. install.packages("KFAS", dependencies=TRUE)

## Memo
- R, Rtools, and RStudio left default without changing anything. Everything is set to "OK" and "Next"
- R and Rtools: about 3.47 GB (+ RStudio about 2.5 GB)
- Preparing files in Documents (C:UsersXXXXXDocuments) makes it easier (where XXXXX is the username)
- Here Japanese RStudio is installed to be able to introduce fonts. Not required in English

## Appendix (settings)
1. "C:\Users\XXXXX\Documents\bashmakePATH.Renviron"
2. PATH="${RTOOLS40_HOME}\usr\bin;${PATH}"

# References
- [1] F. Mukai et al, Biostatistics, kagakudojin, 2011.
- [2] T. Kaise, Seminar, Hyogo university, 2022.