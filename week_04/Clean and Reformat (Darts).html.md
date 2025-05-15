---
title: "Clean and Reformat"
author: "Annabelle Idell"
format: 
  html:
    code-fold: true
    code-line-numbers: true
editor: visual
execute: 
  keep-md: true
warnings: false
---


::: {.cell}

```{.r .cell-code}
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
library(pander)
Darts <- readRDS("Dart_Expert_Dow_6month_anova.rds")
```
:::

::: {.cell}

```{.r .cell-code}
darts2 <- Darts %>% 
  separate(contest_period, into = c("month_begin", "year_end")) %>% 
  separate(year_end, into = c("month_end", "year_end"), sep = -4, remove = FALSE) %>%
  mutate(month_end = ifelse(month_end == "", year_end, month_end)) %>%
  mutate(year_end = ifelse(month_end == year_end, "1993", year_end)) %>% 
  mutate(month_end = ifelse(month_end == "Dec", "December", month_end)) %>% 
  mutate(month_end = ifelse(month_end == "Febuary", "February", month_end))
```

::: {.cell-output .cell-output-stderr}

```
Warning: Expected 2 pieces. Additional pieces discarded in 3 rows [43, 143,
243].
```


:::
:::

::: {.cell}

```{.r .cell-code}
darts_table <- darts2 %>%
  filter(variable == "DJIA") %>%
  mutate(
    Month = factor(month_end, levels = month.name, ordered = TRUE)) %>% 
  select(c(Month, year_end, value)) %>% 
  pivot_wider(names_from = year_end, values_from = value) %>% 
  arrange(Month)

darts_table %>% pander()
```

::: {.cell-output-display}

----------------------------------------------------------------------------
   Month     1990    1991   1992   1993   1994   1995   1996   1997   1998  
----------- ------- ------ ------ ------ ------ ------ ------ ------ -------
  January     NA     -0.8   6.5    -0.8   11.2   1.8     15    19.6   -0.3  

 February     NA      11    8.6    2.5    5.5    3.2    15.6   20.1   10.7  

   March      NA     15.8   7.2     9     1.6    7.3    18.4   9.6     7.6  

   April      NA     16.2   10.6   5.8    0.5    12.8   14.8   15.3   22.5  

    May       NA     17.3   17.6   6.7    1.3    19.5    9     13.3   10.6  

   June       2.5    17.7   3.6    7.7    -6.2    16    10.2   16.2    15   

   July      11.5    7.6    4.2    3.7    -5.3   19.6   1.3    20.8    7.1  

  August     -2.3    4.4    -0.3   7.3    1.5    15.3   0.6    8.3    -13.1 

 September   -9.2    3.4    -0.1   5.2    4.4     14    5.8    20.2   -11.8 

  October    -8.5    4.4     -5    5.7    6.9    8.2    7.2     3      NA   

 November    -12.8   -3.3   -2.8   4.9    -0.3   13.1   15.1   3.8     NA   

 December    -9.3    6.6    0.2     8     3.6    9.3    15.5   -0.7    NA   
----------------------------------------------------------------------------


:::
:::