prepAllG %>% ggplot(aes(Gy,Date)) +
  geom_line(col = palette_light()[1]) +
  geom_point(col = palette_light()[1])

filter(prepAllG, Energy==70) %>% ggplot(aes(Gy,Date)) +
  +   geom_line(col = palette_light()[1]) +
  +   geom_point(col = palette_light()[1])