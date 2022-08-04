# Load Libs ---------------------------------------------------------------
library(tidyverse)
library(here)
library(glue)
library(janitor)
library(readxl)
library(zoo)
library(purrr)


# Load data ---------------------------------------------------------------
# Get 2022 manually
data_22 <- read_xlsx(here("vacancy-survey/data/tab1_state05_2022_rvr.xlsx"),
                     n_max = 56, skip = 3) %>% 
  clean_names() %>% 
  filter(!is.na(state)) %>% 
  select(state, 2, 4, 6, 8) %>% 
  mutate(state = str_remove_all(state, "\\."))

# All tables in one sheet in excel. This grabs each since they are 
# equally spaced out. You skip 63 to start (skipping the 2022 table)
# and then you skip 61 each time to get the next table. This works until 
# first the 7th table, which is 2014. So we can get 2015-2022
for(i in 0:6) {
  skip <- 63+(i*61)
  # Head of for-loop
  assign(paste0("data", i),                                   # Read and store data frames
         read_xlsx(here("vacancy-survey/data/tab1_state05_2022_rvr.xlsx"),
                   skip = skip, n_max = 56) %>% 
           clean_names() %>% 
           filter(!is.na(state)) %>% 
           select(state, 2, 4, 6, 8) %>% 
           mutate(state = str_remove_all(state, "\\."))) 
}



# Join data together ------------------------------------------------------
full_data_raw <- list(data_22,
                  data0,
                  data1,
                  data2,
                  data3,
                  data4,
                  data5,
                  data6) %>% 
  reduce(left_join, by = "state")


# Clean data --------------------------------------------------------------
full_data <- full_data_raw %>% 
  pivot_longer(-state) %>% 
  separate(name, into = c("quarter", "junk", "year"), sep = "_") %>% 
  select(-junk) %>% 
  mutate(quarter = case_when(quarter == "first" ~ 1,
                             quarter == "second" ~ 2,
                             quarter == "third" ~ 3,
                             quarter == "fourth" ~ 4),
         date = as.Date(as.yearqtr(glue("{year}-{quarter}")))) 


# test plot ---------------------------------------------------------------
full_data%>%
  filter(state %in% c("New York", "New Jersey")) %>% 
  ggplot(aes(date, value, color = state)) +
  geom_line()
