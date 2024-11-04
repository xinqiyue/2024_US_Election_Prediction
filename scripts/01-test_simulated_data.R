#### Preamble ####
# Purpose: Tests the structure and validity of the simulated data
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: simulate data first
# Any other information needed? Need to have simulated data


#### Workspace setup ####
library(tidyverse)
library(arrow)

analysis_data <- read_parquet("data/00-simulated_data/simulated_president_polls.parquet")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 100 rows
if (nrow(analysis_data) == 100) {
  message("Test Passed: The dataset has 100 rows.")
} else {
  stop("Test Failed: The dataset does not have 100 rows.")
}

# Check if the dataset has 6 columns
if (ncol(analysis_data) == 6) {
  message("Test Passed: The dataset has 6 columns.")
} else {
  stop("Test Failed: The dataset does not have 6 columns.")
}


# Check if the 'state' column contains only valid Australian state names
valid_states <- c("National", "Arizona", "California", "Georgia", "North Carolina", 
                  "Washington", "Pennsylvania", "New Hampshire", "Texas", "Michigan", 
                  "Nevada", "Wisconsin", "Montana", "Florida", "Ohio", "Massachusetts", "Virginia",
                  "South Carolina", "Nebraska CD-2", "Minnesota", "New York", "Nebraska", "Maryland",
                  "New Mexico", "Connecticut", "Rhode Island", "Missouri", "Indiana", "Iowa", "Vermont",
                  "Maine", "Maine CD-1", "Maine CD-2")

if (all(analysis_data$state %in% valid_states)) {
  message("Test Passed: The 'state' column contains only valid Australian state names.")
} else {
  stop("Test Failed: The 'state' column contains invalid state names.")
}


# Check if there are any missing value
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'state'
if (all(analysis_data$state != "")) {
  message("Test Passed: There are no empty strings in 'state'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if end time are between 2024-10-16 and 2024-10-31
date_range_start <- as.Date('2024-10-16')
date_range_end <- as.Date('2024-10-31')
dataset <- read_csv("data/00-simulated_data/simulated_president_polls.csv")
dataset$within_range <- dataset$end_date >= date_range_start & dataset$end_date <= date_range_end
# Check if all date are within time interval
all_dates_within_range <- all(dataset$within_range)
all_dates_within_range 

# Check if all values in the answer column are either "Donald Trump" or "Kamala Harris" 
valid_answers <- c("Donald Trump", "Kamala Harris") 
only_valid_answers <- all(analysis_data$candidate_name %in% valid_answers) # Output the result 
only_valid_answers # This will return TRUE if all answers are valid, FALSE otherwise


# Check if pct are between 30 to 60
if (all(analysis_data$pct >= 30 & analysis_data$pct <= 60)) {
  message("Test Passed: PCT are between 30 to 60.")
} else {
  stop("Test Failed: PCT exceed the range.")
}


# Check if sample size are between 400 to 8000
if (all(analysis_data$sample_size >= 400 & analysis_data$sample_size <= 8000)) {
  message("Test Passed: Sample size are between 400 to 8000.")
} else {
  stop("Test Failed: Sample size exceed the range.")
}