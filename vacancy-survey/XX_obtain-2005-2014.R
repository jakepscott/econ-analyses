<- 63+
# Head of for-loop
assign(paste0("data", i),                                   # Read and store data frames
       ) 


View(read_xlsx(here("vacancy-survey/data/tab1_state05_2022_rvr.xlsx"), skip = 3) %>% 
     clean_names() %>% 
       #filter(!is.na(state)) %>% 
       select(state, 2, 4, 6, 8) %>% 
       mutate(state = str_remove_all(state, "\\.")))

read_xlsx(here("vacancy-survey/data/tab1_state05_2022_rvr.xlsx"),
          skip = 63 +(7*61)+4, n_max = 56) 
  clean_names() %>% 
  filter(!is.na(state)) %>% 
  select(state, 2, 4, 6, 8) %>% 
  mutate(state = str_remove_all(state, "\\."))
