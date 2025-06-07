
library(tidyverse)
library(lubridate)

# Load and clean data
sales_clean <- read_csv("https://byuistats.github.io/M335/data/sales.csv") %>%
  filter(Name != "Missing", Amount > 0) %>%
  mutate(
    Time = parse_date_time(Time, orders = c("ymd HMS", "ymd HM", "dmy HMS")),
    Date = as.Date(Time),
    Hour = hour(Time)
  )

# 1. Daily transaction amounts per company (line plot)
plot1 <- sales_clean %>%
  group_by(Name, Date) %>%
  summarise(Daily_Amount = sum(Amount), .groups = 'drop') %>%
  ggplot(aes(x = Date, y = Daily_Amount, color = Name)) +
  geom_line() +
  labs(title = "Daily Transaction Amounts by Company",
       x = "Date", y = "Total Daily Amount (USD)", color = "Company") +
  theme_minimal()

# 2. Transaction count per company (default order)
plot2 <- sales_clean %>%
  count(Name) %>%
  ggplot(aes(x = Name, y = n, fill = Name)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Transaction Count per Company",
       x = "Company", y = "Number of Transactions") +
  theme_minimal()

# 3. Hourly transaction amount by company, colored and faceted
hourly_summary <- sales_clean %>%
  group_by(Name, Date, Hour) %>%
  summarise(Hourly_Amount = sum(Amount), .groups = "drop")

plot3 <- ggplot(hourly_summary, aes(x = Hour, y = Hourly_Amount, color = Name)) +
  geom_point(size = 2, alpha = 0.7) +
  facet_wrap(~ Name, nrow = 2, ncol = 3) +
  labs(title = "Hourly Transaction Amounts by Company",
       x = "Hour of Day", y = "Total Amount (USD)", color = "Company") +
  theme_minimal()

plot1
plot2
plot3
