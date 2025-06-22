
library(tidyverse)
library(stringi)

randomletters <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
randomletnums <- readr::read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt")


## Hidden Quote

letters_quote <- str_c(randomletters, collapse = "") %>% 
  str_split("", simplify = TRUE) %>% 
  .[1, ] %>% 
  .[seq(0, length(.), by = 1700)]

letters_quote
# the plural of anecdote is not data.


## Secret Message

numbers <- str_extract_all(randomletnums, "\\d+") %>% unlist() %>% as.numeric()

code <- letters[numbers]

code
# experts often possess more data than judgment


## Longest Sequence of Vowels

vowels <- str_extract_all(randomletters, "[aeiou]{7,}")
# I ran the code using 3, then 4, then 5, etc.

vowels
# oaaoooo


