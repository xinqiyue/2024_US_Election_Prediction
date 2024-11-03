#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(666)

#### Simulate data ####
num_rows <- 100  # Number of simulated rows

president_polls <- data.frame(
  numeric_grade = sample(2:3, num_rows, replace = TRUE),  # Numeric grades between 1 and 5
  pollscore = rnorm(num_rows, mean = -1, sd = 0.5),  # Normally distributed poll scores
  # methodology = sample(c("Online Panel", "Telephone", "Mixed-Mode"), num_rows, replace = TRUE),  # Poll methodologies
  transparency_score = runif(num_rows, min = 1, max = 10),  # Uniform transparency scores between 1 and 10
  state = sample(c("CA", "TX", "FL", "NY", ""), num_rows, replace = TRUE),  # Random states, including blank for nationwide
  start_date = sample(seq(as.Date("2024-10-01"), as.Date("2024-10-15"), by="day"), num_rows, replace = TRUE),  # Random start dates
  end_date = sample(seq(as.Date("2024-10-16"), as.Date("2024-10-31"), by="day"), num_rows, replace = TRUE),  # Random end dates
  sample_size = sample(400:8000, num_rows, replace = TRUE),  # Random sample sizes between 500 and 3000
  population = sample(c("lv", "rv"), num_rows, replace = TRUE),  # Random population groups
  population_full = sample(c("Likely Voters", "Registered Voters"), num_rows, replace = TRUE),  # Random population full descriptions
  hypothetical = sample(c(0, 1), num_rows, replace = TRUE),  # Random TRUE/FALSE for hypothetical
  party = sample(c("DEM", "REP"), num_rows, replace = TRUE),  # Random party affiliations
  answer = sample(c("Kamala Harris", "Donald Trump"), num_rows, replace = TRUE),  # Random answers
  candidate_name = sample(c("Kamala Harris", "Donald Trump"), num_rows, replace = TRUE),  # Random candidate names
  pct = round(runif(num_rows, min = 30, max = 60), 1)  # Random percentages between 30 and 60
)

# Check the first few rows of the simulated data
head(president_polls)

#### Save data ####
write.csv(president_polls, "data/00-simulated_data/simulated_president_polls.csv")
