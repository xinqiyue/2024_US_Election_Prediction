#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggplot2)
library(ggcorrplot)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# 读取清理后的数据
president_polls_cleaned_data <- read.csv('../data/02-analysis_data/president_polls_cleaned_data.csv')

# 描述性统计
#summary_stats <- 
president_polls_cleaned_data %>%
  summarise(
    avg_pct = mean(pct, na.rm = TRUE),
    median_pct = median(pct, na.rm = TRUE),
    min_pct = min(pct, na.rm = TRUE),
    max_pct = max(pct, na.rm = TRUE),
    sd_pct = sd(pct, na.rm = TRUE)
  )
#print(summary_stats)

# 可视化候选人支持率分布
ggplot(president_polls_cleaned_data, aes(x = candidate_name, y = pct, fill = candidate_name)) +
  geom_boxplot() +
  labs(title = "Candidate Support Rate Distribution", y = "Support Rate (%)", x = "Candidate") +
  theme_minimal()

# 时间序列分析
ggplot(president_polls_cleaned_data, aes(x = as.Date(end_date), y = pct, color = candidate_name)) +
  geom_line() +
  labs(title = "Support Rate Trend Over Time", y = "Support Rate (%)", x = "Date") +
  theme_minimal()

# 相关性分析
#correlation_matrix <- 
cor(president_polls_cleaned_data %>% select(pct, sample_size), use = "complete.obs")
#print(correlation_matrix)

state_support_rates <- president_polls_cleaned_data %>%
  group_by(state, candidate_name) %>%
  summarise(avg_pct = mean(pct, na.rm = TRUE)) %>%
  ungroup()

# 可视化支持率
ggplot(state_support_rates, aes(x = state, y = avg_pct, fill = candidate_name)) +
  geom_bar(stat = "identity", position = "dodge", width = ) +
  labs(title = "Support Rates of Donald Trump and Kamala Harris by State",
       y = "Average Support Rate (%)",
       x = "State") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(president_polls_cleaned_data, aes(x = end_date, y = pct, color = candidate_name)) +
  geom_point(size = 0.5) +  # 绘制散点
  facet_wrap(~ state, scales = "free_y") +  # 每个州分面显示，y轴自由
  labs(title = "Support Rates of Donald Trump and Kamala Harris by State",
       y = "Support Rate (%)",
       x = "Date",
       color = "Candidate") +
  theme_minimal() +  # 使用简洁主题
  theme(legend.position = "bottom")  # 图例在底部
# 在此部分添加关于数据的初步观察和发现的总结
