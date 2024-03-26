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

# create list of words----
dict     <- lexicon::grady_augmented
mod.dict <- dict
mod.dict <- mod.dict[!grepl(pattern = "\'", x = mod.dict)]
mod.dict <- mod.dict[nchar(mod.dict) <= 8 & 
                       nchar(mod.dict) > 1]

# GAME STARTS----
# choose 5 consenants
c5 <- sample(lc, size = 5, replace = T)

# choose 3 vowels
v3 <- sample(lv, size = 3, replace = T)

# assemble the scrambled word
scramble <- c(c5,v3) |> 
  sort() |>
  toupper()

# find dict words with scramble letters
