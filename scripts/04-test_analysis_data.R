#### Preamble ####
# Purpose: Test cleaaned data to ensure validity
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: download and clean data first
# Any other information needed? Need to have analysis data/ cleaned data

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

analysis_data <- read_parquet("data/02-analysis_data/president_polls_cleaned_data.parquet")


#### Test data ####

# Check if the dataset has 5 columns
if (ncol(analysis_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
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


# Check if there are any missing values in the dataset
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
# Check if end time exceed 2024-7-21
date_range_start <- as.Date('2024-7-21')
dataset <- read_csv("data/00-simulated_data/simulated_president_polls.csv")
dataset$within_range <- dataset$end_date >= date_range_start
# Check if all date are within time interval
all_dates_within_range <- all(dataset$within_range)
all_dates_within_range 

# Check if all values in the answer column are either "Donald Trump" or "Kamala Harris" 
valid_answers <- c("Donald Trump", "Kamala Harris") 
only_valid_answers <- all(analysis_data$candidate_name %in% valid_answers) # Output the result 
only_valid_answers # This will return TRUE if all answers are valid, FALSE otherwise


# Check if pct are between 0 to 100
if (all(analysis_data$pct >= 0 & analysis_data$pct <= 100)) {
  message("Test Passed: PCT are between 0 to 100.")
} else {
  stop("Test Failed: PCT exceed the range.")
}


# Check if sample size are larger than 0
if (all(analysis_data$sample_size > 0)) {
  message("Test Passed: Sample size are larger than 0.")
} else {
  stop("Test Failed: Sample size are less than and equal to 0.")
}