players$passportArea %>%
  group_by(alpha3code) %>%
  summarise(Frecuencia = n()) %>%
  mutate(Porcentaje = round(prop.table(Frecuencia),2))%>%
  arrange(desc(Porcentaje)) %>%
  head(40)
