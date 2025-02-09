# Data availability for "Connectivity differs by orders of magnitude among co-distributed corals, affecting spatial scales of eco-evolutionary processes" #

This repository contains all scripts and input data files required to run all analyses performed in Meziere et al., (2025).

Raw sequence data is accessible on the NCBI SRA database under the following BioProjects: PRJNA1215558, PRJNA1140372, PRJNA996644.

VCF files are acessible on the University of Queensland eSpace: <add link>

Metadata files are accessible on the GEOME database under the following GUIDs:  https://n2t.net/ark:/21547/Fxv2, https://n2t.net/ark:/21547/FnE2, https://n2t.net/ark:/21547/FnE2.

## Data folder ##

### Metadata folder ###

Metadata files with information on all samples analysed in this study for both species, as well as sites and reefs coordinates used for making maps.

### Kinship folder ###

Output files of COLONY run to find close kins in Stylophora pistillata.

### Diversity folder ###

Output files from PIXY and Stacks Populations with diversity estimates per population for both species.

### ADMIXTURE folder ###

Output files from ADMIXTURE analyses for both species.

### IBD folder ###

Input files: 
  * Census counts: `census_numbers_Pver.csv`, `census_numbers_Spis.csv`, `Pver_census_numbers_grp.csv`, 
  * Spatial coordinates: `Spis_lonlat_pop.csv`, `Pver_lonlat.csv`,
  * S. pistillata cryptic taxa abundance: `Taxa_Spis_counts.csv`,
  * Genepop: `StyloTaxon1_genepop2.txt`, `PverTaxon1A_genepop2.txt`

Output files: 
 * Census counts: `Pver_counts_post.RDS`, `stylo_counts_post.RDS`, `stylo_proportions_post.RDS`
 * Genepop: `Pver_genepop_1d_out.txt.GRA`, `Spis_genepop_2d_out.txt.GRA`, `IBD_Pver.csv`, `IBD_Spis.csv`,
 * NeEstimator: `Spis_NeEstimator_out.txt`, `Spis_Ne_pop.csv`, `PverTaxon1A_Ne_genepopLD_south.txt`, `PverTaxon1A_Ne_genepopLD_north.txt`, `Ne_north_south.csv`

## Scripts folder ##

Above, I describe the use for all scripts present in this folder.

* `Admixture.sh` runs ADMIXTURE analyses to detect population structure.

* `Diversity_Spis_Pver.R` ananlyses diversity estimates output from PIXY and Stacks, and calculates allelic richness.

* `IBD_Spis_Pver.R` creates GenePop input files to perform IBD analyses and plots regressions.

* `Kinship_Spis_Pver.R` creates input files for COLONY to run kinship analyses, and calculate distances between Spis kins idenfitified.

* `NeEstimator_Spis_Pver.R` create input files for NeEstimator

* `PopulationStructure_Pver.` and `PopulationStructure_Spis.R` perform PCA to identify population structure and calculate population pairwise Fst.

* `SamplingSitesMap.R` creates maps for sampled reefs and sites within reefs.

* `census_densisties_counts_Pver.R` and `census_densisties_counts_Spis.R` build models to estimate to census densities.

* `dispersal_modeling_Pver.R` and `dispersal_modeling_Spis.R` build models to estimate sigma and genetic neighborhood.

* `genepop_Pver.R` and `genepop_Spis.R` run GenePop in R to get IBD slope

* `vcf_pixy.sh` creates all sites vcf files and runs pixy.
