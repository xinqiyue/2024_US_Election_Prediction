#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(tidyr)
#### Clean data ####
president_polls_raw_data <- read.csv('data/01-raw_data/president_polls.csv')

# 过滤出高质量民调（numeric_grade >= 2.5）的民调
president_polls_filtered <- president_polls_raw_data %>% 
  janitor::clean_names() %>%
  select(# pollster,
    numeric_grade,# pollscore,
         # methodology,
         # transparency_score,
         state, 
         # start_date, 
         end_date, 
         sample_size,
         #population, population_full,
         # hypothetical,
         answer, candidate_name, pct) %>%
  tidyr::drop_na()

president_polls_cleaned_data <- president_polls_filtered %>%
  mutate(
    #hypothetical = ifelse(hypothetical == 'true', 1, 0),
    state = if_else(is.na(state) | state == "", "National", state), 
    end_date = mdy(end_date),
    #start_date = mdy(start_date),
    num_candidates = round((pct / 100) * sample_size, 0) # 将百分比转换为人数
) %>%
  filter(numeric_grade >= 2.5
         , candidate_name %in% c("Kamala Harris", "Donald Trump")
         , end_date >= as.Date("2024-07-21")
         , !is.na(end_date)  # eliminate date that is null
) %>%
  select(# pollster, numeric_grade, pollscore,
    # methodology,
    # transparency_score,
    state, 
    # start_date, 
    end_date, 
    sample_size,
    #population, population_full, 
    # hypothetical,
    answer, candidate_name, pct)
#### Save data ####
write_csv(president_polls_cleaned_data, 'data/02-analysis_data/president_polls_cleaned_data.csv')
#summary(president_polls_cleaned_data)



base_plot <- ggplot(president_polls_cleaned_data, aes(x = end_date, y = pct, color = candidate_name)) +
  theme_classic() +
  labs(y = "Candidate Support (%)", x = "Date") 
#+  scale_x_date(date_labels = "%b %Y")  # 设置 x 轴只显示月份和年份

# 绘制候选人支持率的点图和光滑线
base_plot + 
  geom_point() + 
  geom_smooth(se = FALSE) + 
  theme(legend.position = "bottom")

