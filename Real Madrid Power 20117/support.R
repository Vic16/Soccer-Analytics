

library(tidyverse)
library(ggsoccer)
library(ggplot2)

pos <- tibble(positions = pases$positions) %>%
  hoist(positions, 
        y = "y",
        x = "x") %>%
  unnest_wider(y, names_sep = "") %>%
  unnest_wider(x, names_sep = "") %>%
  dplyr::select(-positions) %>%
  rename_at(vars(contains(".")), funs(gsub("...", "_", ., fixed = TRUE))) %>%
  dplyr::select(-c(x_2, y_2))


tipo <- c(0:22080)

pos_2 <- cbind(pos, tipo)




#### Real Madrid Contra Celta de Vigo

# Match id = 4406122

pases_contra_celta <- eventos %>%
  filter(matchId == 2565912)

para_graficar_pases <- tibble(positions = pases_contra_celta$positions) %>%
  hoist(positions, 
        y = "y",
        x = "x") %>%
  unnest_wider(y, names_sep = "") %>%
  unnest_wider(x, names_sep = "") %>%
  dplyr::select(-positions) %>%
  rename_at(vars(contains(".")), funs(gsub("...", "_", ., fixed = TRUE))) %>%
  dplyr::select(-c(x_2, y_2))

para_graficar_pases <- cbind(para_graficar_pases, tipo) 

salida_pase <-para_graficar_pases %>%
  filter(tipo %% 2 ==1)

ggplot(salida_pase)   + 
  annotate_pitch(colour = "white" , fill = "#7fc47f", limits = FALSE) + theme_pitch() + geom_point(aes(x = x_1, y = y_1))




