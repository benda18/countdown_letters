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

# make a list of permitted_letters
permitted_ltrs <- sort(unique(scramble))

# make a vector of letters_not.in
prohibited_ltrs <- LETTERS[!LETTERS %in% permitted_ltrs]

# find words in dictory with any prohibited_ltrs
prohibited_words <- grep(pattern = paste(prohibited_ltrs, sep = "|", collapse = "|"), 
     x = mod.dict, 
     ignore.case = T, 
     value = T)

# all possible words
possible_words <- mod.dict[!mod.dict %in% prohibited_words]

# definite words - no repeating letters
nchar_unique <- strsplit(possible_words, "") |>
  lapply(unique) |>
  lapply(length) |>
  unlist()

nchar_full <- nchar(possible_words)
dw_no.rep.ltrs <- possible_words[nchar_unique == nchar_full]
rm(nchar_full, nchar_unique)
