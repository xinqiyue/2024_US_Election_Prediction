#### Preamble ####
# Purpose: Downloads and saves the data from 538 abcNews
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: Null
# Any other information needed? Null

#### Workspace setup ####
library(tidyverse)
#### Download Data ####
president_polls_raw_data <- read_csv("https://projects.fivethirtyeight.com/polls/data/president_polls.csv")

#### Save data ####
write_csv(president_polls_raw_data, "data/01-raw_data/president_polls.csv")