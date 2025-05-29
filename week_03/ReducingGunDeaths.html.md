---
title: "Reducing Gun Deaths"
editor: visual
execute: 
  keep-md: true
warnings: false
format: 
  html: 
    code-fold: true
    code-line-numbers: true
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
gundeaths <- read_csv("C:/Users/annab/Downloads/R/DS350_SP25_Idell_Anna/week_03/full_data.csv")
```

::: {.cell-output .cell-output-stderr}

```
New names:
Rows: 100798 Columns: 11
── Column specification
──────────────────────────────────────────────────────── Delimiter: "," chr
(6): month, intent, sex, race, place, education dbl (5): ...1, year, police,
age, hispanic
ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
Specify the column types or set `show_col_types = FALSE` to quiet this message.
• `` -> `...1`
```


:::
:::


FiveThirtyEight has compiled data on annual gun deaths, exploring the causes for the purpose of finding solutions to reduce gun deaths each year. All data included is from 2012 - 2014, and records age, sex, location, level of education, and race, among others. Homicides are defined as deaths caused by assault or legal intervention, mass shootings indicate that three or more people were killed, and other categories are listed shootings of police officers and terrorism gun deaths. Only data for the deaths of U.S. residents was included.


::: {.cell}

```{.r .cell-code}
gundeaths2 <- gundeaths %>%
  filter(intent %in% c("Accidental", "Homicide", "Suicide")) %>% 
  mutate(month2 = as.numeric(month)) %>% 
  mutate(season = case_when(
    month2 %in% c(12, 1, 2) ~ "Winter",
    month2 %in% c(3, 4, 5) ~ "Spring",
    month2 %in% c(6, 7, 8) ~ "Summer",
    month2 %in% c(9, 10, 11) ~ "Fall")) %>% 
  filter(!is.na(intent))
```
:::

::: {.cell}

```{.r .cell-code}
ggplot(gundeaths2, aes(x = intent, fill = intent)) +
  geom_bar() +
  facet_wrap( ~season, nrow = 1, ncol = 4) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(x = NULL, y = NULL)
```

::: {.cell-output-display}
![](ReducingGunDeaths_files/figure-html/unnamed-chunk-3-1.png){width=672}
:::
:::

::: {.cell}

```{.r .cell-code}
ggplot(gundeaths2, aes(x = age)) +
  geom_bar() +
  facet_wrap(~month, nrow = 4, ncol = 3) +
  labs(x = "Age at Death", y = "Number of Deaths in the Month") +
  theme_bw()
```

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 17 rows containing non-finite outside the scale range
(`stat_count()`).
```


:::

::: {.cell-output-display}
![](ReducingGunDeaths_files/figure-html/unnamed-chunk-4-1.png){width=672}
:::
:::


The first graph addresses the amount of gun deaths that can be attributed to intent for each season. Consistently, suicide is the leading reason for gun deaths, followed by homicide, and then accident. Interestingly, Summer sees the highest rates of gun deaths for each category except Accident, and Winter sees the lowest amount.

The second graph addresses the rates of gun deaths by age in each month. The highest spike can be seen in April around the 20s, and the lowest count overall can be found in February. Each month noticeably follows a similar pattern of distribution of age, with some variability for count.
