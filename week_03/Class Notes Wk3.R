library(tidyverse)
idata <- iris %>%  
  arrange(Sepal.Length) %>% 
  mutate(ratio = Sepal.Width / Sepal.Length) %>%
  select(Species, ratio) %>%
  group_by(Species) %>% 
  summarise(m_ratio = mean(ratio),
            sd_ratio = sd(ratio))

  head()

  ?distinct
  
?n()
?slice

View(iris)  

vspecies <- iris %>% 
  filter(Species == c("versicolor" | "virginica"))



# 5/7/25

a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, list(-5, "fish")))

a[[c(4,2,2)]]
a[c(4,2,2)]

library(tidyverse)
mpg #tibble
mtcars #data frame

money <- c('4,554,25', '$45', '8025.33cents', '288f45')
money
class(money)

parse_number(money)


