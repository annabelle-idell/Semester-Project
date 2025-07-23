
## Fertility Rate - Our World in Data

library(tidyverse)
library(haven)

# Is there a difference between the two sexes in views about children?


GSS <- read_dta("C:/Users/annab/Downloads/GSS_stata/GSS_stata/gss7224_r1.dta")

# age, sex, childs, chldidel, kidnofre, happy, hapmar, 

GSS2 <- GSS %>% 
  select(c(age, sex, childs, chldidel, agekdbrn, kidnofre, happy, 
           hapmar, adoptkid, adoption)) %>% 
  filter(!is.na(sex))
  
ideal <- GSS2 %>% 
  select(c(age, sex, chldidel)) %>% 
  filter(!is.na(chldidel))

freedom <- GSS2 %>% 
  select(c(age, sex, kidnofre)) %>% 
  filter(!is.na(kidnofre))

happiness <- GSS2 %>% 
  select(c(age, sex, childs, happy)) %>% 
  filter(!is.na(childs)) %>% 
  filter(!is.na(happy))
