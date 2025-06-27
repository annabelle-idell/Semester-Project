---
title: "Chipotle"
format: 
  html:
    code-line-numbers: true
    code-fold: true
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
```
:::

::: {.cell}

```{.r .cell-code}
mystring <- list('{"Monday":94,"Tuesday":76,"Wednesday":89,"Thursday":106,"Friday":130,"Saturday":128,"Sunday":58}')

weekday <- str_extract_all(mystring, "[:alpha:]+") %>% unlist()

customers <- str_extract_all(mystring, "\\d+") %>% unlist()

mytibble <- tibble(weekday, customers)


## Functions

chipotle <- function(x) {
  weekday <- str_extract_all(x, "[:alpha:]+") %>% unlist()
  customers <- str_extract_all(x, "\\d+") %>% unlist() %>% as.numeric()
  tibble(weekday, customers) %>% arrange(desc(customers))
}

chipotle_day <- function(x) {
  chipotle(x) %>% slice_max(customers, n = 1)
}
```
:::



## Test 1

::: {.cell}

```{.r .cell-code}
chipotle('{“Monday”:94,“Tuesday”:76,“Wednesday”:89,“Thursday”:106,“Friday”:130,“Saturday”:128,“Sunday”:58}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  weekday   customers
  <chr>         <dbl>
1 Friday          130
2 Saturday        128
3 Thursday        106
4 Monday           94
5 Wednesday        89
6 Tuesday          76
7 Sunday           58
```


:::

```{.r .cell-code}
chipotle_day('{"Monday":94,"Tuesday":76,"Wednesday":89,"Thursday":106,"Friday":130,"Saturday":128,"Sunday":58}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 1 × 2
  weekday customers
  <chr>       <dbl>
1 Friday        130
```


:::
:::



## Test 2

::: {.cell}

```{.r .cell-code}
chipotle('{“Monday”:18,“Tuesday”:16,“Wednesday”:14,“Thursday”:27,“Friday”:26,“Saturday”:36,“Sunday”:20}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  weekday   customers
  <chr>         <dbl>
1 Saturday         36
2 Thursday         27
3 Friday           26
4 Sunday           20
5 Monday           18
6 Tuesday          16
7 Wednesday        14
```


:::

```{.r .cell-code}
chipotle_day('{“Monday”:18,“Tuesday”:16,“Wednesday”:14,“Thursday”:27,“Friday”:26,“Saturday”:36,“Sunday”:20}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 1 × 2
  weekday  customers
  <chr>        <dbl>
1 Saturday        36
```


:::
:::



## Test 3

::: {.cell}

```{.r .cell-code}
chipotle('{“Monday”:0,“Tuesday”:0,“Wednesday”:1,“Thursday”:0,“Friday”:0,“Saturday”:1,“Sunday”:0}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 7 × 2
  weekday   customers
  <chr>         <dbl>
1 Wednesday         1
2 Saturday          1
3 Monday            0
4 Tuesday           0
5 Thursday          0
6 Friday            0
7 Sunday            0
```


:::

```{.r .cell-code}
chipotle_day('{“Monday”:0,“Tuesday”:0,“Wednesday”:1,“Thursday”:0,“Friday”:0,“Saturday”:1,“Sunday”:0}')
```

::: {.cell-output .cell-output-stdout}

```
# A tibble: 2 × 2
  weekday   customers
  <chr>         <dbl>
1 Wednesday         1
2 Saturday          1
```


:::
:::
