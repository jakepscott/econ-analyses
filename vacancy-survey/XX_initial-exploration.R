# Load Libs ---------------------------------------------------------------
library(tidyverse)
library(here)
library(glue)
library(janitor)
library(readxl)
library(zoo)


# Need 16 total but only works for first 9 here (2015-2022)
for(i in 0:9) {
  skip <- 63+(i*61)
  # Head of for-loop
  assign(paste0("data", i),                                   # Read and store data frames
         read_xlsx(here("vacancy-survey/data/tab1_state05_2022_rvr.xlsx"),
                   skip = skip, n_max = i + 51) %>% 
           clean_names() %>% 
           filter(!is.na(state)) %>% 
           select(state, 2, 4, 6, 8) %>% 
           mutate(state = str_remove_all(state, "\\."))) 
}



%>% 
  left_join(data1)


library(datapasta)
library(purrr)

joined <- list(data1,
               data2,
               data3,
               data4,
               data5,
               data6,
               data7,
               data8,
               data9) %>% 
  reduce(left_join, by = "state")

(c( data0,
                                      )
