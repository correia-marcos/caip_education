# =============================================================================
# Paper: Commodity Booms and Literacy: Historical Evidence from
# Brazilian Municipalities
# =============================================================================
# Goal: We use this program to convert the first Stata program of the paper.
# 
# This program is made to merge two datasets:
#   1 - From Ehrl (2017): the Minimum Comparable Areas (MNA) for municipalities
#   2 - 1872 Empire General Census for Brazil
# 
# @Date: jun 2023.
# @author: Marcos (Research assistant)

rm(list = ls())

# Required libraries
require(haven)

# Read libraries
library(haven)
library(dplyr)

# Read first dataset. You can download it in: 
# https://sites.google.com/site/philippehrl/research
# under: Minimum Comparable Areas for the period 1872-2010: An aggregation ...
mna <- read_dta('./Data/raw/_Crosswalk_1872_2010_final.dta')


# We (1) Change class of the code_2010 column;  (2) make new column w/ first 2
# numbers; (3) remove municipalities with empty value in 1870, since they were 
# neither existent or part of another municipality; (4) remove unnecessary 
# columns from dataset
mna$code2010 <- as.character(mna$code2010)

mna <- mna %>%
  rename(municipality = muname1872) %>% 
  mutate(uf = substr(code2010, 1, 2)) %>% 
  select(code2010,municipality, uf) %>% 
  filter(municipality != "")

# Save this dataset
write.csv(mna, './Data/processed_data/auxiliar.csv')

# Opening the second dataset for merging

