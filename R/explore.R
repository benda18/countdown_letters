# EXPLORE

library(renv)
library(lexicon)

rm(list=ls());cat('\f')
gc()

renv::status()
renv::snapshot()

# vars----
lv <- c("a", "e", "i", "o", "u")
lc <- letters[!letters %in% lv]


dict <- lexicon::grady_augmented
mod.dict <- dict
mod.dict <- mod.dict[!grepl(pattern = "\'", x = mod.dict)]
mod.dict <- mod.dict[nchar(mod.dict) <= 8 & 
                       nchar(mod.dict) > 1]




