# EXPLORE

library(renv)

rm(list=ls());cat('\f')
gc()

renv::status()
renv::snapshot()

# vars----
lv <- c("a", "e", "i", "o", "u")
lc <- letters[!letters %in% lv]

