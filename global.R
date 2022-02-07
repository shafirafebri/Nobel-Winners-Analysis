library(shinydashboard)
library(shiny)
library(tidyverse)
library(glue)
library(plotly)
library(lubridate)
library(gghighlight)
library(DT)
library(shinyWidgets)

# Load Data
nobel <- read.csv("nobel_final.csv")

# cleaning data
nobel_clean <- nobel %>%
  mutate(born_country_code = as.factor(born_country_code),
    died_country_code = as.factor(died_country_code),
    born_month = as.factor(born_month),
    category = as.factor(category),
    country_of_university = as.factor(country_of_university),
    fullname =  paste(firstname, surname))

#handling missing value
nobel_clean[nobel_clean == ""] <- NA 

#year as factor
year_factor <- nobel_clean %>% 
  select(year) %>% 
  mutate(year = as.factor(year))
year_factor
