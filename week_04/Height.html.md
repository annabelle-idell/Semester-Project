---
title: "Country Heights"
author: "Annabelle Idell"
format: 
  html:
    code-fold: true
    code-line-numbers: true
execute: 
  keep-md: true
editor: visual
warnings: false
---


::: {.cell}

```{.r .cell-code}
library(readxl)
library(tidyverse)
```

::: {.cell-output .cell-output-stderr}

```
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```


:::

```{.r .cell-code}
Height <- read_excel("C:/Users/annab/Downloads/R/DS350_SP25_Idell_Anna/week_04/Height.xlsx", skip = 1)

View(Height)
```
:::

::: {.cell}

```{.r .cell-code}
heights2 <- Height %>%
  mutate("country" = `Continent, Region, Country`) %>% 
  select(c(Code, country, "1810":"1980")) %>% 
  filter(!is.na(Code) & !is.na(country)) %>%
  filter(country != "Federal Republic of Germany (until 1990)") %>% 
  pivot_longer(c('1810':'1980'), 
               names_to = "year_decade", 
               values_to = "height_cm") %>% 
  filter(!is.na(height_cm))
  


#'1810':'1980'
```
:::

::: {.cell}

```{.r .cell-code}
ggplot(heights2, aes(x = year_decade, y = height_cm, group = country)) +
  geom_line(color = "darkgray", pch = 19) +
  geom_line(data = subset(heights2, country == "Germany"), color = "blue", pch = 19, size = 1) +
  labs(x = "Year (Decades)", y = "Height (cm)") +
  theme_bw()
```

::: {.cell-output .cell-output-stderr}

```
Warning in geom_line(color = "darkgray", pch = 19): Ignoring unknown
parameters: `shape`
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
ℹ Please use `linewidth` instead.
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning in geom_line(data = subset(heights2, country == "Germany"), color =
"blue", : Ignoring unknown parameters: `shape`
```


:::

::: {.cell-output-display}
![](Height_files/figure-html/unnamed-chunk-3-1.png){width=672}
:::
:::


The data displayed features the average heights for countries around the world over four decades. A claim has been made that humans are growing taller over time, which is supported by the data in this visual. Before 1840, there appears to be very little growth. Gradually after that point, height seems to climb, with many countries even surpassing 170cm tall. Highlighted in blue, the Federal Republic of Germany declined in height until 1850, when average height began to grow until reaching over 180 cm in 1980. From looking at this visual, I would support the claim that height is growing taller over the years, faster for some countries than others, but generally trending upward. I would also predict that average height continues to increase after 1980. 

