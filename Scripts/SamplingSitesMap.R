#Script to create map of sampling sites

sites_Pver_Spis <- read.csv("sites_Pver_Spis.csv", header = TRUE)

setEPS()
postscript("GBRmap.ps")
ggplot(data = gbr_feat) +
  theme_bw() +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), 
        axis.text.x = element_text(size=8), axis.text.y = element_text(size=8)) +
  geom_sf(lwd = 0.01, fill = "grey") +
  coord_sf(xlim = c(142, 155), ylim = c(-27, -9)) +
  annotation_scale(location = "bl", width_hint = 0.5) +
  geom_point(data = sites_Pver_Spis, mapping = aes(x = decimalLongitude, y = decimalLatitude), alpha = 1, size = 1, colour = "grey35") 
dev.off()
