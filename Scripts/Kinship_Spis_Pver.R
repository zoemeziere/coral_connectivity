#Script to create input files for COLONY, to perform kinship analyses, for both Stylopora pistillata and Pocillopora verrucosa, 
#and to calculate distances between identified kin individuals of S. pistillata

#Create COLONY input S.pis
StyloTaxon1_genlight <- gl.read.vcf("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/SpisTaxon1/StyloTaxon1_SF095_LD.vcf")
StyloTaxon1_tidy <- tidy_genlight(StyloTaxon1_genlight)
StyloTaxon1_tidy_colony <- write_colony(StyloTaxon1_tidy)

#Create COLONY input P.ver

#Calculate individual distances between S.pis kins
#For each pair, get coordinates from metatada and replace ind1Lon,ind1Lat and ind2Lon,ind2Lat in bellow lines
ind1= st_point(c(ind1Lon, ind1Lat))
ind2= st_point(c(ind2Lon,	ind2Lat))
distance<- st_distance(st_sfc(ind1, crs = 'OGC:CRS84'), st_sfc(ind2, crs = 'OGC:CRS84'))
