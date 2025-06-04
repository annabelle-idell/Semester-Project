
library(tidyverse)
library(lubridate)

mdy("January 12th, 2017")

day <- mdy("March 23rd, 2016")
yday(day)


jan31 <- ymd("2013-01-31")
jan31_t <- ymd_hms("2013-01-31 06:35:27")

jan31_t + hours(27) + minutes(15)

floor_date()
round_date()
ceiling_date()
timezones()
force_tz() #to change the timezone from UTC, but not the label
with_tz() #changes the timezone and lable
Sys.timezone(location = TRUE)

