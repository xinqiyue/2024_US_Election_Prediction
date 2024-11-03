#### Preamble ####
# Purpose: Cleans the raw plane data recorded
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed?

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(tidyr)
library(arrow)

#### Clean data ####
president_polls_raw_data <- read.csv('data/01-raw_data/president_polls.csv')

# filter out high quality polls（numeric_grade >= 2.5)
president_polls_filtered <- president_polls_raw_data %>% 
  janitor::clean_names() %>%
  select(# pollscore, methodology, transparency_score, start_date, population, population_full, hypothetical, answer, pollster,
    numeric_grade,
    state, 
    end_date, 
    sample_size,
    candidate_name, 
    pct) %>%
  tidyr::drop_na()

president_polls_cleaned_data <- president_polls_filtered %>%
  mutate(
    # hypothetical = ifelse(hypothetical == 'true', 1, 0),start_date = mdy(start_date),
    state = if_else(is.na(state) | state == "", "National", state), 
    end_date = mdy(end_date),
    # num_candidates = round((pct / 100) * sample_size, 0)
) %>%
  filter(numeric_grade >= 2.5
         , candidate_name %in% c("Kamala Harris", "Donald Trump")
         , end_date >= as.Date("2024-07-21")
         , !is.na(end_date)  # eliminate date that is null
) %>%
  select(# pollscore, methodology, transparency_score, start_date, population, population_full, hypothetical, answer, pollster,
    state, 
    end_date, 
    sample_size,
    candidate_name,
    pct)

#### Save data ####
write_parquet(president_polls_cleaned_data, "data/02-analysis_data/president_polls_cleaned_data.parquet")