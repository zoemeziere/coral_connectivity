library(dplyr)

#Census density Spis

Spis_census_numbers <- read.csv("census_numbers_Spis.csv") #read census numbers
Spis_census_numbers_grp <- Spis_census_numbers %>% group_by(EcoSiteID) %>% summarise(count = n_distinct(Colony)) #get census numbers per site
Spis_census_numbers_grp$Density <- Spis_census_numbers_grp$count/288 #get census density (area of one site = 288m2)
SpisTaxon1_abundance <- read.csv("SpisTaxon1_abundance.csv") #read relatice abundance of Taxon1 at each site
Spis_census_numbers_grp$Taxon1Abun <- SpisTaxon1_abundance$Taxon1Abun 
Spis_census_numbers_grp$DensityCorrected <- Spis_census_numbers_grp$Density*Spis_census_numbers_grp$Taxon1Abun #correct density by relative abundance
Spis_census_numbers_grp[Spis_census_numbers_grp==0] <- NA #remove rows with zeros (no samples from those sites)
Spis_census_numbers_grp <- na.omit(Spis_census_numbers_grp) #remove rows with NA (no samples from those sites)

mean(Spis_census_numbers_grp$DensityCorrected)
var(Spis_census_numbers_grp$DensityCorrected)

#Census density Pver

Pver_census_numbers <- read.csv("census_numbers_Pver.csv") #read census numbers
Pver_census_numbers_grp <- Pver_census_numbers %>% group_by(EcoSiteID) %>% summarise(count = n_distinct(Colony)) #get census numbers per site
Pver_census_numbers_grp$Density <- Pver_census_numbers_grp$count/288 #get census density (area of one site = 288m2)
Pver_census_numbers_grp[Pver_census_numbers_grp==0] <- NA #remove rows with zeros (no samples from those sites)
Pver_census_numbers_grp <- na.omit(Pver_census_numbers_grp) #remove rows with NA (no samples from those sites)

mean(Pver_census_numbers_grp$Density)
var(Pver_census_numbers_grp$Density)
