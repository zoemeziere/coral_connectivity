# Script to calculate sigma (dispersla kernel spread) and confidence intervals, using IBD regression slope and effective or census densities
# b: IBD regression slope obtained in Genepop
# NS: neigborhood size
# Ne_local: effective size at the reef/population scale
# Ne_global: effective size at the GBR scale
# De_local: effective density at the reef/population scale
# De_global: effective density at the GBR scale
# Dc_site: census density at site scale
# Dc_global: census density at global scale

#Input data from Genepop
Spis_b=
Pver_b=

#Calculate NS
Spis_NS= 1/Spis_b
Pver_NS= 1/Pver_b

#Input files for effective and census population sizes
Spis_Ne <- read.csv()
Pver_Ne <- read.csv()

Spis_Nc <- read.csv()
Pver_Nc <- read.csv()

#Calculate effective and census densities at global scale
Spis_Ne$global <- mean(Spis_Ne$local)
Pver_Ne$global <- mean(Pver_Ne$local)

#


