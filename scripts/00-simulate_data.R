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
set.seed(666)

#### Simulate data ####
num_rows <- 100  # Number of simulated rows

simulated_president_polls <- data.frame(
  # pollster = sample(c("Emerson", "YouGov", "Beacon/Shaw", "Quinnipiac", "SurveyUSA", "East Carolina University", "Fairleigh Dickinson", "Ipsos", "Marist", "Siena/NYT", "University of Massachusetts Lowell/YouGov", "Marquette Law School", "Hart/POS", "The Washington Post", "Pew", "Suffolk", "Mason-Dixon",
                      #"Christopher Newport U.", "Data for Progress", "YouGov/Center for Working Class Politics", "UC Berkeley", "Winthrop U.", "High Point University", "McCourtney Institute/YouGov", "Echelon Insights", "CNN/SSRS", "AtlasIntel", "University of Maryland/Washington Post", "Remington", "Muhlenberg", 
                      #"MassINC Polling Group", "U. New Hampshire",  "Siena", "Elon U.", "Selzer", "Data Orbital", "PPIC", "Washington Post/George Mason University", "Kaiser Family Foundation", "SurveyUSA/High Point University", "Roanoke College", "YouGov Blue", "U. North Florida"), num_rows, replace = TRUE),
  # numeric_grade = sample(2:3, num_rows, replace = TRUE),  # Numeric grades between 1 and 5
  # pollscore = rnorm(num_rows, mean = -1, sd = 0.5),  # Normally distributed poll scores
  # methodology = sample(c("IVR/Online Panel/Text-to-Web", "Online Panel", "IVR/Online Panel", "Live Phone/Text-to-Web",
                         #"Live Phone", "IVR/Text-to-Web", "Probability Panel", "Online Panel/Text-to-Web", 
                         #"Live Phone/Online Panel/Text-to-Web", "Email", "Live Phone/Online Panel",
                         #"Live Phone/Text-to-Web/Email/Mail-to-Web/Mail-to-Phone", "Online Ad"
                         #,"Live Phone/Online Panel/Text", "Live Phone/Email", "Live Phone/Probability Panel", "IVR")
                       #, num_rows, replace = TRUE),  # Poll methodologies
  # transparency_score = runif(num_rows, min = 1, max = 10),  # Uniform transparency scores between 1 and 10
  # population = sample(c("lv", "rv"), num_rows, replace = TRUE),  # Random population groups
  # population_full = sample(c("Likely Voters", "Registered Voters"), num_rows, replace = TRUE),  # Random population full descriptions
  # hypothetical = sample(c(0, 1), num_rows, replace = TRUE),  # Random TRUE/FALSE for hypothetical
  # party = sample(c("DEM", "REP"), num_rows, replace = TRUE),  # Random party affiliations
  # start_date = sample(seq(as.Date("2024-10-01"), as.Date("2024-10-15"), by="day"), num_rows, replace = TRUE),  # Random start dates
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
write.csv(simulated_president_polls, "data/00-simulated_data/simulated_president_polls.csv")
