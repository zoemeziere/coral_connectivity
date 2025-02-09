#Script to create GenePopinput files to perform IBD analyses for both S. pistillata and P. verrucsa, and plot IBD regressions

library(dartR)
library(ggplot2)

####Stylophora pistillata

##Create input file for Genepop

#Create file with individual geographic coordinates
StyloTaxon1_pop_mercator <- read.csv("Spis_lonlat_pop.csv")
StyloTaxon1_pop_genlight_mercator <- StyloTaxon1_genlight
StyloTaxon1_pop_genlight_mercator@ind.names <- StyloTaxon1_pop_mercator$lonlat
StyloTaxon1_pop_genlight_mercator@pop <- as.factor(StyloTaxon1_pop_mercator$pop)
StyloTaxon1_pop_genepop_mercator <- gl2genepop(StyloTaxon1_pop_genlight_mercator)
write.table(StyloTaxon1_pop_genepop_mercator, file = "Spis_pop_genepop.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#Then use following command in terminal and run Genepop with StyloTaxon1_pop_genepop2.txt
#sed 's/pop.*_//' Spis_pop_genepop.txt > Spis_pop_genepop2.txt

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
PverTaxon1A_mercator <- read.csv("Pver_lonlat_pop.csv")
PverTaxon1A_genlight_mercator <- PverTaxon1A_genlight
PverTaxon1A_genlight_mercator@ind.names <- PverTaxon1A_mercator$lonlat
PverTaxon1A_genlight_mercator@pop <- as.factor(PverTaxon1A_mercator$lonlat)
PverTaxon1A_genepop_mercator <- gl2genepop(PverTaxon1A_genlight_mercator)
write.table(PverTaxon1A_genepop_mercator, file = "Pver_genepop.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#Then use following command in terminal and run Genepop with PverTaxon1A_genepop2.txt
#sed 's/pop.*_//' Pver_genepop.txt > Pver_genepop2.txt

##Plot IBD regression using Genepop outputs in IBD_Pver.csv

Pver_IBD <- read.csv("IBD_Pver.csv")
ggplot() + 
  geom_point(data=Pver_IBD, aes(x = geodist, y = gendist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Pver_IBD, aes(x = geodist, y = gendist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Geographic distance (m)") +
  #stat_regline_equation(label.x = 0, label.y = 0.55) +
  theme_Publication()
