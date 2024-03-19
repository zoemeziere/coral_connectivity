#Script to create GenePopinput files to perform IBD analyses for both S. pistillata and P. verrucsa, and plot IBD regressions

####Stylophora pistillata

##Create input file for Genepop

#Create file with individual geogrpahic coordinates
StyloTaxon1_lonlat <- read.csv("StyloTaxon1_lonlat.csv")
StyloTaxon1_cord.lonlat = SpatialPoints(StyloTaxon1_lonlat, proj4string = CRS("+proj=longlat"))
StyloTaxon1_cord.UTM <- spTransform(StyloTaxon1_cord.lonlat, CRS("+init=epsg:32748"))
write.csv(StyloTaxon1_cord.UTM, "StyloTaxon1_latlon_mercator.csv") #manually modify to concatenante lon and lat and add a pop, output file nammed lonlat_StyloTaxon1_pop.csv
StyloTaxon1_mercator <- read.csv("lonlat_StyloTaxon1_pop.csv")

StyloTaxon1_pop_mercator <- read.csv("lonlat_StyloTaxon1_pop.csv")
StyloTaxon1_pop_genlight_mercator <- StyloTaxon1_genlight
StyloTaxon1_pop_genlight_mercator@ind.names <- StyloTaxon1_pop_mercator$lonlat
StyloTaxon1_pop_genlight_mercator@pop <- as.factor(StyloTaxon1_pop_mercator$pop)
StyloTaxon1_pop_genepop_mercator <- gl2genepop(StyloTaxon1_pop_genlight_mercator)
write.table(StyloTaxon1_pop_genepop_mercator, file = "StyloTaxon1_pop_genepop.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#Then use following command in terminal and run Genepop with StyloTaxon1_pop_genepop2.txt
#sed 's/pop.*_//' StyloTaxon1_pop_genepop.txt > StyloTaxon1_pop_genepop2.txt

##Plot IBD regression using Genepop outputs in IBD_Spis.csv

Spis_IBD <- read.csv("IBD_Spis.csv")
ggplot() + 
  geom_point(data=Spis_IBD, aes(x = geodist, y = gendist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Spis_IBD, aes(x = geodist, y = gendist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Ln (geographic distance (m))") +
  theme_Publication()

####Pocillopora verrucosa

##Create input file for Genepop

#Create file with individual geogrpahic coordinates
Pver_lonlat <- read.csv("Pver_lonlat.csv")
Pver_cord.lonlat = SpatialPoints(Pver_lonlat, proj4string = CRS("+proj=longlat"))
Pver_cord.UTM <- spTransform(cord.lonlat, CRS("+init=epsg:32748"))
write.csv(cord.UTM, "Pver_latlon_mercator.csv") #manually modify to concatenante lon and lat and add a pop, output file nammed lonlat_Pver.csv
PverTaxon1A_mercator <- read.csv("lonlat_Pver.csv")

PverTaxon1A_genlight_mercator <- PverTaxon1A_genlight
PverTaxon1A_genlight_mercator@ind.names <- PverTaxon1A_mercator$lonlat
PverTaxon1A_genlight_mercator@pop <- as.factor(PverTaxon1A_mercator$lonlat)
PverTaxon1A_genepop_mercator <- gl2genepop(PverTaxon1A_genlight_mercator)
write.table(PverTaxon1A_genepop_mercator, file = "PverTaxon1A_genepop.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#Then use following command in terminal and run Genepop with PverTaxon1A_genepop2.txt
#sed 's/pop.*_//' PverTaxon1A_genepop.txt > PverTaxon1A_genepop2.txt

##Plot IBD regression using Genepop outputs in IBD_Pver.csv

Pver_IBD <- read.csv("IBD_Pver.csv")
ggplot() + 
  geom_point(data=Pver_IBD, aes(x = geodist, y = gendist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Pver_IBD, aes(x = geodist, y = gendist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Geographic distance (m)") +
  #stat_regline_equation(label.x = 0, label.y = 0.55) +
  theme_Publication()
