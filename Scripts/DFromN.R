#Script to calculate census and effective densities from population sizes
library(dplyr)

### Census densities 
setwd("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/IBD_Spis_Pver")

#Spis

Spis_census_numbers <- read.csv("census_numbers_Spis.csv") #read census numbers
SpisTaxon1_abundance <- read.csv("SpisTaxon1_abundance.csv") #read relatice abundance of Taxon1 at each site

Spis_census_numbers_grp <- Spis_census_numbers %>% group_by(EcoSiteID) %>% summarise(count = n_distinct(Colony)) #get census numbers per site
Spis_census_numbers_grp$Density <- Spis_census_numbers_grp$count/288 #get census density (area of one site = 288m2)
Spis_census_numbers_grp$Taxon1Abun <- SpisTaxon1_abundance$Taxon1Abun 
Spis_census_numbers_grp$DensityCorrected <- Spis_census_numbers_grp$Density*Spis_census_numbers_grp$Taxon1Abun #correct density by relative abundance
Spis_census_numbers_grp[Spis_census_numbers_grp==0] <- NA #remove rows with zeros (no samples from those sites)
Spis_census_numbers_grp <- na.omit(Spis_census_numbers_grp) #remove rows with NA (no samples from those sites)

mean(Spis_census_numbers_grp$DensityCorrected)
var(Spis_census_numbers_grp$DensityCorrected)

#Pver

Pver_census_numbers <- read.csv("census_numbers_Pver.csv") #read census numbers
Pver_census_numbers_grp <- Pver_census_numbers %>% group_by(EcoSiteID) %>% summarise(count = n_distinct(Colony)) #get census numbers per site
Pver_census_numbers_grp$Density <- Pver_census_numbers_grp$count/288 #get census density (area of one site = 288m2)
Pver_census_numbers_grp[Pver_census_numbers_grp==0] <- NA #remove rows with zeros (no samples from those sites)
Pver_census_numbers_grp <- na.omit(Pver_census_numbers_grp) #remove rows with NA (no samples from those sites)

mean(Pver_census_numbers_grp$Density)
var(Pver_census_numbers_grp$Density)

### Effective densities 
setwd("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/IBD_Spis_Pver")

#Spis
Spis_Ne_pop <- read.csv("Spis_Ne_pop.csv") #read table with NeEstimator output (Ne by population)

Spis_Ne_pop$NeChromo <- Spis_Ne_pop$Ne/(0.098+0.219*log(28)) #correction for low levels of linkage following Waples, Larson and Waples (2016)
Spis_Ne_pop$De <- Spis_Ne_pop$NeChromo / Spis_Ne_pop$Area #effective density for each population

mean(Spis_Ne_pop$De) #averaged, range wide, effective density

#Pver
Pver_Ne = 33031.2
Pver_Ne_low = 23915.5
Pver_Ne_high = 53346.3
  
Pver_NeChromo <- Pver_Ne/(0.098+0.219*log(28)) #correction for low levels of linkage following Waples, Larson and Waples (2016)
Pver_De <- Pver_NeChromo / 1973667 #devided by lengh of GBR to obtain De

mean(Pver_Ne_pop$Density) # averaged, range wide, effective density
