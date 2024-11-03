#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

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

# Check if the dataset has 3 columns
if (ncol(analysis_data) == 3) {
  message("Test Passed: The dataset has 3 columns.")
} else {
  stop("Test Failed: The dataset does not have 3 columns.")
}

# Check if all values in the 'division' column are unique
if (n_distinct(analysis_data$division) == nrow(analysis_data)) {
  message("Test Passed: All values in 'division' are unique.")
} else {
  stop("Test Failed: The 'division' column contains duplicate values.")
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

# Check if the 'party' column contains only valid party names
valid_parties <- c("DEM", "REP")

if (all(analysis_data$party %in% valid_parties)) {
  message("Test Passed: The 'party' column contains only valid party names.")
} else {
  stop("Test Failed: The 'party' column contains invalid party names.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'division', 'state', and 'party' columns
if (all(analysis_data$division != "" & analysis_data$state != "" & analysis_data$party != "")) {
  message("Test Passed: There are no empty strings in 'division', 'state', or 'party'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'party' column has at least two unique values
if (n_distinct(analysis_data$party) >= 2) {
  message("Test Passed: The 'party' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'party' column contains less than two unique values.")
}