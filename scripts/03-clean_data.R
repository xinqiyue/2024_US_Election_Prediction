#### Preamble ####
# Purpose: Cleans the raw plane data recorded
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: Null
# Any other information needed? Null

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(tidyr)
library(arrow)

#### Clean data ####
president_polls_raw_data <- read_csv('data/01-raw_data/president_polls.csv') # import raw data

president_polls_filtered <- president_polls_raw_data %>% 
  janitor::clean_names() %>% # correct name to standard form
  select( # only keep needed columns
    numeric_grade,
    state, 
    end_date, 
    sample_size,
    candidate_name, 
    pct) %>%
  tidyr::drop_na() # eliminate date that is null

president_polls_cleaned_data <- president_polls_filtered %>%
  mutate(
    state = if_else(is.na(state) | state == "", "National", state), 
    end_date = mdy(end_date),
) %>%
  filter(numeric_grade >= 2.5 # filter out high quality polls（numeric_grade >= 2.5)
         , candidate_name %in% c("Kamala Harris", "Donald Trump") # filter out data of Kamala Harris and Donald Trump
         , end_date >= as.Date("2024-07-21") # filter out data after byden was out
         , !is.na(end_date)  # eliminate date that is null
) %>%
  select( # only keep needed columns
    state, 
    end_date, 
    sample_size,
    candidate_name,
    pct)

#### Save data ####
write_parquet(president_polls_cleaned_data, "data/02-analysis_data/president_polls_cleaned_data.parquet")