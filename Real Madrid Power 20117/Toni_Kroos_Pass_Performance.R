
library(dplyr)
library(ggplot2)
library(jsonlite)
library(ggsoccer)





matches <- fromJSON("data/matches/matches_Spain.json", flatten = TRUE)
players <- read.csv("data/Real_Madrid_Players.csv")
eventos <- fromJSON("data/eventos_real_madrid.json")





#Buscamos el ID de T. Kroos

players <- as_tibble(players[c("shortName", "wyId")])
players[12:15,1:2]



#Nos quedamos con los eventos del jugador

eventos <- eventos %>%
  filter(playerId == "14723")

#Nos quedamos con los pases
pases <-eventos %>%
  filter(eventName %in% c("Pass"))

#Elegimos el partido contra el Celta

pases_contra_celta <- pases %>%
  filter(matchId == 2565912)




## Para extraer la posición del evento (viene anidada) utilicé la función de Ismael Gomez ![link](https://github.com/Dato-Futbol/xg-model/blob/master/getshots.R) 



### Tomo los eventos del primer tiempo

primer_tiempo <- pases_contra_celta %>%
  filter(pases_contra_celta$matchPeriod =="1H") 

coordenadas <- tibble(positions = primer_tiempo$positions) %>%
  hoist(positions, 
        y = "y",
        x = "x") %>%
  unnest_wider(y, names_sep = "") %>%
  unnest_wider(x, names_sep = "") %>%
  dplyr::select(-positions) %>%
  rename_at(vars(contains(".")), funs(gsub("...", "_", ., fixed = TRUE))) #%>%
#dplyr::select(-c(x_2, y_2))




ggplot(coordenadas)   + 
  annotate_pitch(colour = "white" , fill = "#7fc47f", limits = FALSE) + theme_pitch() + geom_point(aes(x = x_1, y = y_1))
