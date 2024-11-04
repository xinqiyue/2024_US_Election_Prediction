#### Preamble ####
# Purpose: simulate data to give first idea
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: Null
# Any other information needed? Null

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)
set.seed(666)

#### Simulate data ####
num_rows <- 100  # Number of simulated rows

simulated_president_polls <- data.frame(
  state = sample(c("National", "Arizona", "California", "Georgia", "North Carolina", 
                   "Washington", "Pennsylvania", "New Hampshire", "Texas", "Michigan", 
                   "Nevada", "Wisconsin", "Montana", "Florida", "Ohio", "Massachusetts", "Virginia", 
                   "South Carolina", "Nebraska CD-2", "Minnesota", "New York", "Nebraska", "Maryland", 
                   "New Mexico", "Connecticut", "Rhode Island", "Missouri", "Indiana", "Iowa", "Vermont",
                   "Maine", "Maine CD-1", "Maine CD-2"), num_rows, replace = TRUE),  # Random states, including blank for nationwide
  end_date = sample(seq(as.Date("2024-10-16"), as.Date("2024-10-31"), by="day"), num_rows, replace = TRUE),  # Random end dates
  sample_size = sample(400:8000, num_rows, replace = TRUE),  # Random sample sizes between 500 and 3000
  # answer = sample(c("Kamala Harris", "Donald Trump"), num_rows, replace = TRUE),  # Random answers
  candidate_name = sample(c("Kamala Harris", "Donald Trump"), num_rows, replace = TRUE),  # Random candidate names
  pct = round(runif(num_rows, min = 30, max = 60), 1)  # Random percentages between 30 and 60
  #, num_candidates = round((pct / 100) * sample_size, 0)
)

#### Save data ####
write_parquet(simulated_president_polls, "data/00-simulated_data/simulated_president_polls.parquet")