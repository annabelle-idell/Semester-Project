---
title: "Distance between Savior Names"
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
library(stringi)

scriptures <- read_csv("https://github.com/beandog/lds-scriptures/raw/master/csv/lds-scriptures.csv")
```

::: {.cell-output .cell-output-stderr}

```
Rows: 41995 Columns: 19
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr (13): volume_title, book_title, volume_long_title, book_long_title, volu...
dbl  (6): volume_id, book_id, chapter_id, verse_id, chapter_number, verse_nu...

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


:::

```{.r .cell-code}
savior_names <- read_rds("https://byuistats.github.io/M335/data/BoM_SaviorNames.rds")
```
:::

::: {.cell}

```{.r .cell-code}
scriptures <- scriptures %>% 
  filter(volume_short_title == "BoM")

the_names <- str_c(savior_names$name, collapse = "|")

scriptures2 <- str_c(scriptures$scripture_text) %>% 
  str_flatten() %>% str_split(pattern = the_names)

word_count <- unlist(scriptures2) %>% str_count(pattern = "\\S+") 

mean_count <- mean(word_count)
# 63.2

word_tibble <- tibble(word_count) %>% 
  filter(word_count >= 0)
```
:::

::: {.cell}

```{.r .cell-code}
ggplot(data = word_tibble, aes(word_count)) +
  geom_histogram(binwidth = 25, color  ="black", fill = "lightgray") +
  geom_vline(xintercept = mean_count, color = "red", lty = 2) +
  scale_x_continuous(limit = c(0,750),
                     breaks = seq(0, 1000, 100)) +
  labs(title = "The Average Words Between the Savior's \nNames in the Book of Mormon is 63.2",
       x = "Number of Words",
       y = "Frequency") +
  theme_bw()
```

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 16 rows containing non-finite outside the scale range
(`stat_bin()`).
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning: Removed 2 rows containing missing values or values outside the scale range
(`geom_bar()`).
```


:::

::: {.cell-output-display}
![](Distance-Between-Savior-Names_files/figure-html/unnamed-chunk-3-1.png){width=672}
:::
:::


## AI Disclosure

I chose to use ChatGPT AI to assist me with this assignment by tutoring me on how to use the functions and troubleshooting my code. I chose to use this tool because I was stuck on how to continue and I wasn't feeling very confident with the necessary functions. It affected my learning by correcting some of my functions and syntax, but overall it wasn't very helpful, and it wasn't able to clarify some of the things I was confused about.
