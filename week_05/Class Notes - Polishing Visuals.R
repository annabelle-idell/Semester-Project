library(tidyverse)

ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species) +
         geom_point() +
         scale_x_continuous(breaks = 2:4)
       
       
       
p <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) + geom_point() + scale_x_continuous(breaks = 2:4, labels = c("2cm", "3cm", "4cm")) +
         scale_y_continuous(breaks = seq(from = 4.5, to = 8, by = .5))
       
install.packages("directlabels")
library(directlabels)
       
direct.label(p, list("last.points", dl.trans(c = x-1.5, y = y+2)))
# or direct.label(p, list("last.points", hjust = 1, vjust = .1))