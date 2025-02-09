#Script to analyse diversity measurements obtained in PIXY and STACKS for both S. pistillata and P. verrucosa,
#and to measure other diversity estimaties in R.

library(dplyr)
library(PopGenReport)

### Stylophora pistillata

#Load PIXY output file containing pi values
pi_pixy_Spis<-read.table("Spis_pixy_out.txt",sep="\t",header=T)

#Filter by popualtion
pi_pixy_Spis_Pelorus <- pi_pixy_Spis %>% filter(pop == "Pelorus")
pi_pixy_Spis_Lady_Musgrave <- pi_pixy_Spis %>% filter(pop == "Lady Musgrave")
pi_pixy_Spis_Heron <- pi_pixy_Spis %>% filter(pop == "Heron")
pi_pixy_Spis_Moore <- pi_pixy_Spis %>% filter(pop == "Moore")
pi_pixy_Spis_Lizard <- pi_pixy_Spis %>% filter(pop == "Lizard")
pi_pixy_Spis_Davies <- pi_pixy_Spis %>% filter(pop == "Davies")
pi_pixy_Spis_Little_Broadhurst <- pi_pixy_Spis %>% filter(pop == "Little Broadhurst")
pi_pixy_Spis_Chicken <- pi_pixy_Spis %>% filter(pop == "Chicken")

#Sum according to PIXY manual recommendations 
(sum(pi_pixy_Spis_Pelorus$count_diffs[!is.na(pi_pixy_Spis_Pelorus$count_diffs)])) / (sum(pi_pixy_Spis_Pelorus$count_comparisons[!is.na(pi_pixy_Spis_Pelorus$count_comparisons)]))
#0.01488884
sum(pi_pixy_Spis_Lady_Musgrave$count_diffs[!is.na(pi_pixy_Spis_Lady_Musgrave$count_diffs)]) / sum(pi_pixy_Spis_Lady_Musgrave$count_comparisons[!is.na(pi_pixy_Spis_Lady_Musgrave$count_comparisons)])
#0.01489349
sum(pi_pixy_Spis_Heron$count_diffs[!is.na(pi_pixy_Spis_Heron$count_diffs)]) / sum(pi_pixy_Spis_Heron$count_comparisons[!is.na(pi_pixy_Spis_Heron$count_comparisons)])
#0.01515458
sum(pi_pixy_Spis_Lizard$count_diffs[!is.na(pi_pixy_Spis_Lizard$count_diffs)]) / sum(pi_pixy_Spis_Lizard$count_comparisons[!is.na(pi_pixy_Spis_Lizard$count_comparisons)])
#0.01787387
sum(pi_pixy_Spis_Davies$count_diffs[!is.na(pi_pixy_Spis_Davies$count_diffs)]) / sum(pi_pixy_Spis_Davies$count_comparisons[!is.na(pi_pixy_Spis_Davies$count_comparisons)])
#0.01762858
sum(pi_pixy_Spis_Little_Broadhurst$count_diffs[!is.na(pi_pixy_Spis_Little_Broadhurst$count_diffs)]) / sum(pi_pixy_Spis_Little_Broadhurst$count_comparisons[!is.na(pi_pixy_Spis_Little_Broadhurst$count_comparisons)])
#0.01712479
sum(pi_pixy_Spis_Chicken$count_diffs[!is.na(pi_pixy_Spis_Chicken$count_diffs)]) / sum(pi_pixy_Spis_Chicken$count_comparisons[!is.na(pi_pixy_Spis_Chicken$count_comparisons)])
#0.01835996
sum(pi_pixy_Spis_Moore$count_diffs[!is.na(pi_pixy_Spis_Moore$count_diffs)]) / sum(pi_pixy_Spis_Moore$count_comparisons[!is.na(pi_pixy_Spis_Moore$count_comparisons)])
#0.01935028

#Allelic richness
Spis_metadata <- read.csv("Spis_metadata.csv")
StyloTaxon1_genlight$pop <- Spis_metadata$locality
SpisTaxon1_genind <- gl2gi(StyloTaxon1_genlight)
SpisTaxon1_genind@pop <- as.factor(StyloTaxon1_metadata$locality)
StyloTaxon1_AR <- allel.rich(SpisTaxon1_genind)

### Pocillopora verrucosa

#Load PIXY output file containing pi values
pi_pixy_Pver<-read.table("Pver_pixy_out.txt",sep="\t",header=T)

pi_pixy_Pver_Pelorus <- pi_pixy_Pver %>% filter(pop == "Pelorus")
pi_pixy_Pver_Moore <- pi_pixy_Pver %>% filter(pop == "Moore")
pi_pixy_Pver_Lizard <- pi_pixy_Pver %>% filter(pop == "Lizard")
pi_pixy_Pver_Davies <- pi_pixy_Pver %>% filter(pop == "Davies")
pi_pixy_Pver_Little_Broadhurst <- pi_pixy_Pver %>% filter(pop == "Little Broadhurst")
pi_pixy_Pver_Chicken <- pi_pixy_Pver %>% filter(pop == "Chicken")

#Sum according to PIXY manual recommendations 
(sum(pi_pixy_Pver_Pelorus$count_diffs[!is.na(pi_pixy_Pver_Pelorus$count_diffs)])) / (sum(pi_pixy_Pver_Pelorus$count_comparisons[!is.na(pi_pixy_Pver_Pelorus$count_comparisons)]))
#0.01036451
sum(pi_pixy_Pver_Lizard$count_diffs[!is.na(pi_pixy_Pver_Lizard$count_diffs)]) / sum(pi_pixy_Pver_Lizard$count_comparisons[!is.na(pi_pixy_Pver_Lizard$count_comparisons)])
#0.01017709
sum(pi_pixy_Pver_Davies$count_diffs[!is.na(pi_pixy_Pver_Davies$count_diffs)]) / sum(pi_pixy_Pver_Davies$count_comparisons[!is.na(pi_pixy_Pver_Davies$count_comparisons)])
#0.01022332
sum(pi_pixy_Pver_Little_Broadhurst$count_diffs[!is.na(pi_pixy_Pver_Little_Broadhurst$count_diffs)]) / sum(pi_pixy_Pver_Little_Broadhurst$count_comparisons[!is.na(pi_pixy_Pver_Little_Broadhurst$count_comparisons)])
#0.01025255
sum(pi_pixy_Pver_Chicken$count_diffs[!is.na(pi_pixy_Pver_Chicken$count_diffs)]) / sum(pi_pixy_Pver_Chicken$count_comparisons[!is.na(pi_pixy_Pver_Chicken$count_comparisons)])
#0.01028486
sum(pi_pixy_Pver_Moore$count_diffs[!is.na(pi_pixy_Pver_Moore$count_diffs)]) / sum(pi_pixy_Pver_Moore$count_comparisons[!is.na(pi_pixy_Pver_Moore$count_comparisons)])
#0.01004208

#Allelic richness
Pver_metadata <- read.csv("Pver_metadata.csv")
Pver_genlight$pop <- Pver_metadata$locality
PverSpisTaxon1_genind <- gl2gi(Pver_genlight)
Pver_genind@pop <- as.factor(Pver_metadata$locality)
Pver_AR <- allel.rich(Pver_genind)
