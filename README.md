# Forecasting the 2024 US Presidential Election：A Poll-of-Polls Approach Using Bayesian Modeling

## Overview
This study examines the dynamics of voter support for the 2024 U.S. Presidential Election, focusing on candidates Kamala Harris and Donald Trump. Given the heightened public interest and the complexities of polling data, we adopt a "poll-of-polls" methodology, aggregating high-quality national and state polls to forecast candidate support. By utilizing Bayesian modeling, this analysis captures both the temporal dynamics and state-specific trends influencing voter behavior.

## Key Findings
Our model indicates stable support for Kamala Harris at an estimated 52% nationally, with a confidence interval of approximately 49% to 55%. In contrast, Donald Trump’s predicted support centers around 46%, with a range of about 43% to 49%, showing a slight downward trend as the election date approaches. Notably, Harris demonstrates stronger support in traditionally Democratic areas, such as Maine CD-1, where predicted support reaches around 62%. Conversely, battleground states like Georgia, Florida, and Pennsylvania reveal closely contested support levels, highlighting competitive dynamics in these regions.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from 538 abc News.
-   `data/simulated_data` contains the simulated data.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, test, explore, clean and model data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The title, abstract, readme file and Appendix A were written with the help of ChatGPT_4o and the entire chat history is available in inputs/llms/usage.txt.
