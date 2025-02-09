#Script to create input files for NeEstimator, for both Stylopora pistillata and Pocillopora verrucosa

##Pocillopora verrucosa
PverTaxon1A_genlight <- gl.read.vcf("Pver_filtered.vcf")
PverTaxon1A_genlight_Ne <- PverTaxon1A_genlight
PverTaxon1A_genlight_Ne@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_Ne_genepop <- gl2genepop(PverTaxon1A_genlight_Ne)

write.table(PverTaxon1A_4pops_Ne_genepop, file = "Pver_NeEstimator_in.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

##Stylopora pistillata
StyloTaxon1_genlight <- gl.read.vcf("Spis_filtered.vcf")
StyloTaxon1_genlight_Ne <- StyloTaxon1_genlight
StyloTaxon1_genlight_Ne@ind.names <- StyloTaxon1_metadata$Sample_name
StyloTaxon1_genlight_Ne@pop <- as.factor(StyloTaxon1_metadata$locality)
StyloTaxon1_Ne_genepop <- gl2genepop(StyloTaxon1_genlight_Ne)

write.table(StyloTaxon1_Ne_genepop, file = "Spis_NeEstimator_in.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)
