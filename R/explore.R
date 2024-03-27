# EXPLORE

library(renv)
#library(lexicon)
library(readr)

rm(list=ls());cat('\f')
gc()

renv::status()
renv::snapshot()

# vars----
lv <- c("a", "e", "i", "o", "u")
lc <- letters[!letters %in% lv]

# create list of words----
mod.dict <- read_csv("data/scrabbledict.csv")
mod.dict <- mod.dict[!grepl(pattern = "\'", x = mod.dict)]
mod.dict <- mod.dict[nchar(mod.dict) <= 8 & 
                       nchar(mod.dict) > 1]

# GAME STARTS----
# choose 5 consenants
c5 <- sample(lc, size = 5, replace = T)

# choose 3 vowels
v3 <- sample(lv, size = 3, replace = T)
rm(lc,lv)

# assemble the scrambled word
scramble <- c(c5,v3) |> 
  sort() |>
  toupper()
rm(c5,v3)


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
rm(permitted_ltrs, prohibited_ltrs, prohibited_words, mod.dict)

# definite words - no repeating letters
nchar_unique <- strsplit(possible_words, "") |>
  lapply(unique) |>
  lapply(length) |>
  unlist()

nchar_full <- nchar(possible_words)
dw_words <- possible_words[nchar_unique == nchar_full]
print(dw_words)
rm(nchar_full, nchar_unique)

# remaining possible words
possible_words <- possible_words[!possible_words %in% dw_words]


# remove words that have more letters than allowed

for(i.word in possible_words){
  temp.ltrs <- strsplit(x = i.word, 
                        split = "") |>
    unlist()
  all.letters.good <- NULL
  for(i.ltr in unique(temp.ltrs)){
    # number of i.ltr in possible word
    n_temp.ltr     <- sum(i.ltr == temp.ltrs)
    # number of i.ltr in scramble word
    n_scramble.ltr <- sum(i.ltr == tolower(unlist(strsplit(x = scramble, ""))))
    
    if(n_scramble.ltr >= n_temp.ltr){
      
      all.letters.good <- c(all.letters.good, T)
    }else{
      all.letters.good <- c(all.letters.good, F)
    }
  }
  if(all(all.letters.good)){
    #stop("it's good")
    # if all letters are good, add to definite words
    dw_words <- c(dw_words, i.word)
  }
  # remove from remaining possible words
  possible_words <- possible_words[!possible_words %in% i.word]
  
}
rm(i.word, temp.ltrs)

dw_words
scramble
