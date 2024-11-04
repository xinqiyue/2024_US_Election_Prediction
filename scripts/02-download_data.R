#### Preamble ####
# Purpose: Downloads and saves the data from 
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: Null
# Any other information needed? Null

#### Workspace setup ####
library(tidyverse)
president_polls_raw_data <- read.csv('data/01-raw_data/president_polls.csv')

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
# write_csv(the_raw_data, "inputs/data/raw_data.csv") 
