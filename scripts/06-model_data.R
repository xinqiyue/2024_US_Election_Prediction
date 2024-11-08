#### Preamble ####
# Purpose: Create predictive Bayesian Modeling
# Author: Xinqi Yue
# Date: 3 Nov 2024
# Contact: xinqi.yue@mail.utoronto.ca
# License: MIT
# Pre-requisites: Null
# Any other information needed? Null

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(broom)
library(modelsummary)
library(rstanarm)
library(arrow)
library(splines)
library(caret)

#### Read data ####
president_polls_cleaned_data <- read_parquet("data/02-analysis_data/president_polls_cleaned_data.parquet")

#### Construct Model ####
# Change 'state','candidate_name' to factor variables

# Set seed for reproducibility
set.seed(666)

# Create a train/test split (80% training, 20% testing)
train_index <- createDataPartition(president_polls_cleaned_data$pct, 
                                   p = 0.8, 
                                   list = FALSE)

train_data <- president_polls_cleaned_data[train_index, ]
test_data <- president_polls_cleaned_data[-train_index, ]

# Change 'state', 'candidate_name' to factor variables in train_data
train_data <- train_data |> 
  mutate(
    state = factor(state),
    candidate_name = factor(candidate_name)
  )

# Fit the Bayesian regression model
model_bayes <- stan_glm(
  pct ~ end_date + candidate_name + sample_size + state,
  data = president_polls_cleaned_data,
  family = gaussian(),
  prior_intercept = normal(50, 10),
  prior = normal(0, 2.5),
  chains = 4,
  seed = 666,
  iter = 2000,
  chains = 4,
  refresh = 0
)

# Change 'state', 'candidate_name' to factor variables in test_data
test_data <- test_data |> 
  mutate(
    state = factor(state),
    candidate_name = factor(candidate_name)
  )

# Make predictions on the test dataset
predictions <- posterior_predict(model_bayes, newdata = test_data)

# Calculate mean predictions
mean_predictions <- colMeans(predictions)

# Create a dataframe for comparison
results <- data.frame(
  actual = test_data$pct,
  predicted = mean_predictions
)

# Calculate RMSE
rmse <- sqrt(mean((results$actual - results$predicted) ^ 2))
r_squared <- 1 - (sum((results$actual - results$predicted) ^ 2) / 
                    sum((results$actual - mean(results$actual)) ^ 2))

# Display RMSE and R²
print(paste("RMSE:", rmse))
print(paste("R-squared:", r_squared))

# Example new data for prediction
new_data <- expand.grid(
  end_date = as.Date("2024-11-08"),  # Date of the election
  candidate_name = factor(c("Kamala Harris", "Donald Trump")),  # Candidates
  sample_size = c(1000),  # Sample size can be the same for both candidates
  state = factor(c("National", "Arizona", "California", "Georgia", "North Carolina", 
                   "Washington", "Pennsylvania", "New Hampshire", "Texas", "Michigan", 
                   "Nevada", "Wisconsin", "Montana", "Florida", "Ohio", "Massachusetts", "Virginia", 
                   "South Carolina", "Nebraska CD-2", "Minnesota", "New York", "Nebraska", "Maryland", 
                   "New Mexico", "Connecticut", "Rhode Island", "Missouri", "Indiana", "Iowa", "Vermont",
                   "Maine", "Maine CD-1", "Maine CD-2"))  # Actual states
)

# Make sure the sample size is repeated for each candidate-state combination
new_data$sample_size <- rep(c(1000, 1000), times = length(unique(new_data$state)))

# Make predictions for the new data
predictions_new <- posterior_predict(model_bayes, newdata = new_data)

# Calculate mean predictions for new data
mean_predictions_new <- colMeans(predictions_new)

# Create a data frame containing the states, candidate names, and corresponding average predictions
state_names <- levels(new_data$state)

# Prepare the result dataframe
prediction_results <- data.frame(
  state = rep(state_names, each = 2),  # Twice in each state, one for each candidate
  candidate_name = rep(levels(new_data$candidate_name), times = length(state_names)),
  predicted_pct = c(mean_predictions_new[1:length(state_names)], mean_predictions_new[(length(state_names)+1):(2*length(state_names))])
)

# Assuming you have already run the previous code up to the predictions_new part

# Create a dataframe for the predictions with specific columns
prediction_summary <- data.frame(
  state = rep(state_names, each = 2),  # Repeat state names for each candidate
  candidate_name = rep(levels(new_data$candidate_name), times = length(state_names)),
  predicted_pct = c(mean_predictions_new[1:length(state_names)], 
                    mean_predictions_new[(length(state_names) + 1):(2 * length(state_names))])
)

final_results <- prediction_summary |> 
  select(state, candidate_name, predicted_pct) |>  # Select relevant columns
  pivot_wider(names_from = candidate_name, values_from = predicted_pct, 
              names_prefix = "predicted_pct_of_")  # Pivot to wide format

summary(model_bayes)
pp_check(model_bayes)

# Save model for future use
saveRDS(model_bayes, "models/election_glm_model.rds")
