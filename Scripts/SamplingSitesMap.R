#Script to create map of sampling sites

library(ggplot2)
library(gisaimsr)
library(ggspatial)

sites_Pver_Spis <- read.csv("sites_Pver_Spis.csv", header = TRUE)

ggplot(data = gbr_feat) +
  theme_bw() +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), 
        axis.text.x = element_text(size=8), axis.text.y = element_text(size=8)) +
  geom_sf(lwd = 0.01, fill = "grey") +
  coord_sf(xlim = c(142, 155), ylim = c(-27, -9)) +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme_bw() +
  geom_point(data = sites_Pver_Spis, mapping = aes(x = decimalLongitude, y = decimalLatitude), alpha = 1, size = 1, colour = "grey35") 

#Inset map of Lizard island

Lizard_coordinates <- read.csv("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/Map/Lizard_coordinates.csv", header = FALSE)

gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(145.42, 145.5), ylim = c(-14.62, -14.72)) +
  geom_point(data = Lizard_coordinates, mapping = aes(x = V3, y = V2), size = 3, colour = "grey20", ) +
  theme_bw() +
  theme(legend.position = "none")

#Inset maps for all reefs showing all sampling sites

Coordinates <- read.csv("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/Map/all_sites_coords.csv", header=T)

# Lizard
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(145.42, 145.5), ylim = c(-14.62, -14.72)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Moore
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(146.15, 146.31), ylim = c(-16.832358, -16.958937)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Pelorus
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(146.477137, 146.510181), ylim = c(-18.534951, -18.578918)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Chicken
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(147.662234, 147.773775), ylim = c(-18.583381, -18.710030)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Little Braodhurst
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(147.657171, 147.726001), ylim = c(-18.915563, -18.993370)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Davies
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(147.616100, 147.674980), ylim = c(-18.799013, -18.852469)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Heron
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(151.898566, 151.99), ylim = c(-23.419785, -23.478557)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20", ) +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Lady Musgrave
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(152.380344, 152.431013), ylim = c(-23.88, -23.923)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20") +
  geom_text(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude, label = EcoLocationID_short), size = 3, colour = "black", vjust = -0.5, hjust = 0.5) +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

# Masig
gbr_feat %>%
  dplyr::filter(FEAT_NAME != "Mainland") %>%
  ggplot(data = .) +
  geom_sf(mapping = aes(fill = FEAT_NAME)) +
  scale_fill_manual(values = c(Rock = 'grey', Cay = 'grey', Sand = 'grey', Island = 'grey', Reef = 'ivory2')) +
  coord_sf(xlim = c(143.39, 143.46), ylim = c(-9.732, -9.75)) +
  geom_point(data = Coordinates, mapping = aes(x = decimalLongitude, y = decimalLatitude), size = 3, colour = "grey20") +
  theme_bw() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  theme(legend.position = "none")

