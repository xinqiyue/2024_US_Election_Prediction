#### Preamble ####
# Purpose: Create exploratory data analysis
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: download, clean and test data first
# Any other information needed? Need to have analysis data

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggplot2)
library(ggcorrplot)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# read from cleaned data
president_polls_cleaned_data <- read.csv('../data/02-analysis_data/president_polls_cleaned_data.csv')

# summarise data
president_polls_cleaned_data %>%
  summarise(
    avg_pct = mean(pct, na.rm = TRUE),
    median_pct = median(pct, na.rm = TRUE),
    min_pct = min(pct, na.rm = TRUE),
    max_pct = max(pct, na.rm = TRUE),
    sd_pct = sd(pct, na.rm = TRUE)
  )

# Visualize the distribution of candidate support
ggplot(president_polls_cleaned_data, aes(x = candidate_name, y = pct, fill = candidate_name)) +
  geom_boxplot() +
  labs(title = "Candidate Support Rate Distribution", y = "Support Rate (%)", x = "Candidate") +
  theme_minimal()

# Time Series Analysis
ggplot(president_polls_cleaned_data, aes(x = as.Date(end_date), y = pct, color = candidate_name)) +
  geom_line() +
  labs(title = "Support Rate Trend Over Time", y = "Support Rate (%)", x = "Date") +
  theme_minimal()

cor(president_polls_cleaned_data %>% select(pct, sample_size), use = "complete.obs")

state_support_rates <- president_polls_cleaned_data %>%
  group_by(state, candidate_name) %>%
  summarise(avg_pct = mean(pct, na.rm = TRUE)) %>%
  ungroup()

# Correlation analysis
ggplot(state_support_rates, aes(x = state, y = avg_pct, fill = candidate_name)) +
  geom_bar(stat = "identity", position = "dodge", width = ) +
  labs(title = "Support Rates of Donald Trump and Kamala Harris by State",
       y = "Average Support Rate (%)",
       x = "State") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(president_polls_cleaned_data, aes(x = end_date, y = pct, color = candidate_name)) +
  geom_point(size = 0.5) +
  facet_wrap(~ state, scales = "free_y") +
  labs(title = "Support Rates of Donald Trump and Kamala Harris by State",
       y = "Support Rate (%)",
       x = "Date",
       color = "Candidate") +
  theme_minimal() +
  theme(legend.position = "bottom")
