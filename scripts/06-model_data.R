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
library(janitor)
library(lubridate)
library(broom)
library(modelsummary)
library(rstanarm)
library(splines)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
#### 准备数据集 ####
# 读取数据并清理变量名称
president_polls_data <- read.csv('data/02-analysis_data/president_polls_cleaned_data.csv')

#### 初步模型 ####
# 模型 1：pct 作为 end_date 的函数
model_date <- lm(pct ~ end_date, data = president_polls_cleaned_data)

# 模型 2：pct 作为 end_date 和候选人的函数
model_date_candidates <- lm(pct ~ end_date + candidate_name,
                            #+ transparency_score + sample_size + numeric_grade + pollscore + num_candidates, 
                            data = president_polls_cleaned_data)

# 将模型预测添加到数据中
president_polls_cleaned_data <- president_polls_cleaned_data |> 
  mutate(
    fitted_date = predict(model_date),
    fitted_date_candidates = predict(model_date_candidates)
  )

# 绘制模型预测
# 模型 1
ggplot(president_polls_cleaned_data, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date), color = "blue", linetype = "dotted") +
  theme_classic() +
  labs(y = "Candidate Support (%)", x = "Date", title = "Linear Model: pct ~ end_date")

# 模型 2
ggplot(president_polls_cleaned_data, aes(x = end_date)) +
  geom_point(aes(y = pct, color = candidate_name)) +
  geom_line(aes(y = fitted_date_candidates), color = "blue", linetype = "dotted") +
  facet_wrap(vars(candidate_name)) +
  theme_classic() +
  labs(y = "Candidate Support (%)", x = "Date", title = "Linear Model: pct ~ end_date + candidate_name")

#### 贝叶斯模型 ####
# 将 'candidate_name' 和 'state' 转换为因子变量
president_polls_cleaned_data <- president_polls_cleaned_data |> 
  mutate(
    candidate_name = factor(candidate_name),
    state = factor(state)
  )

# 模型 1
model_formula_1 <- cbind(num_candidates, sample_size - num_candidates) ~ (1 | candidate_name)

# 指定先验
priors <- normal(0, 2.5, autoscale = TRUE)

# 拟合模型
bayesian_model_1 <- stan_glmer(
  formula = model_formula_1,
  data = president_polls_cleaned_data,
  family = binomial(link = "logit"),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95 
)

# 总结模型
summary(bayesian_model_1)

# 绘制随机效应
plot(bayesian_model_1, pars = "(Intercept)", prob = 0.95)

#### 贝叶斯模型与样条 ####
# 将日期转换为自声明的天数
president_polls_cleaned_data <- president_polls_cleaned_data |> 
  mutate(
    end_date_num = as.numeric(end_date - min(end_date))
  )

# 拟合贝叶斯模型
spline_model <- stan_glm(
  pct ~ ns(end_date_num, df = 5) + candidate_name,
  data = president_polls_cleaned_data,
  family = gaussian(),
  prior = normal(0, 5),
  prior_intercept = normal(50, 10),
  seed = 1234,
  iter = 2000,
  chains = 4,
  refresh = 0
)

# 总结模型
summary(spline_model)

# 创建用于预测的新数据
new_data <- data.frame(
  end_date_num = seq(
    min(president_polls_cleaned_data$end_date_num),
    max(president_polls_cleaned_data$end_date_num),
    length.out = 100
  ),
  candidate_name = factor("Candidate A", levels = levels(president_polls_cleaned_data$candidate_name))
)

# 预测后验
posterior_preds <- posterior_predict(spline_model, newdata = new_data)

# 总结预测
pred_summary <- new_data |> 
  mutate(
    pred_mean = colMeans(posterior_preds),
    pred_lower = apply(posterior_preds, 2, quantile, probs = 0.025),
    pred_upper = apply(posterior_preds, 2, quantile, probs = 0.975)
  )

# 绘制样条拟合
ggplot(president_polls_cleaned_data, aes(x = end_date_num, y = pct, color = candidate_name)) +
  geom_point() +
  geom_line(data = pred_summary, aes(x = end_date_num, y = pred_mean), color = "blue", inherit.aes = FALSE) +
  geom_ribbon(data = pred_summary, aes(x = end_date_num, ymin = pred_lower, ymax = pred_upper), alpha = 0.2, inherit.aes = FALSE) +
  labs(
    x = "Days since earliest poll",
    y = "Percentage",
    title = "Poll Percentage over Time with Spline Fit"
  ) +
  theme_minimal()























first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


