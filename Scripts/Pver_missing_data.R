#Additional analyses using datasets with less missing data for Pocillora verrucosa (<15% and <5% missing data)

library(ggplot2)
library(dartR)
library(dplyr)
library(ggsignif)
library(reshape2)

#### Metadata ####

PverTaxon1A_metadata <- read.csv("Pver_metadata.csv") %>% arrange(Sample_name)
PverTaxon1A_metadata$locality <- factor(PverTaxon1A_metadata$locality, levels = c("Flinders", "Lady Musgrave", "Heron", "Little Broadhurst", "Chicken", "Davies", "Pelorus", "Moore", "Lizard", "Masig", "Aukane", "Dungeness"))

PverTaxon1A_080_genlight <- gl.read.vcf("Pver_filtered.recode.vcf")
PverTaxon1A_085_genlight <- gl.read.vcf("Pver_filtered_085.vcf")
PverTaxon1A_095_genlight <- gl.read.vcf("Pver_filtered_095.vcf")

#### PCA ####

# PCA Missing data = 0.80
PCA_PverTaxon1A_080 <- glPca(PverTaxon1A_080_genlight, parallel= TRUE) 
PCA_PverTaxon1A_080.df <- as.data.frame(PCA_PverTaxon1A_080$scores)
PC=1:10
pve_PverTaxon1 <- data.frame(PC, 100*PCA_PverTaxon1A_080$eig[1:10]/sum(PCA_PverTaxon1A_080$eig[1:10]))

ggplot(PCA_PverTaxon1A_080.df, aes(PC1, PC2, col= PverTaxon1A_metadata$locality)) + 
  geom_point(stroke= 0, size=8, alpha=0.5, show.legend = TRUE) +
  coord_equal() + theme_bw() + theme(axis.text=element_text(size=16), axis.title=element_text(size=16)) +
  labs(x= paste0("PC1 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_080.eig.1.10..sum.PCA_PverTaxon1A_080.eig.1.10..[1], 3), "%)"),
       y = paste0("PC2 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_080.eig.1.10..sum.PCA_PverTaxon1A_080.eig.1.10..[2], 3), "%)"))

# PCA Missing data = 0.85
PCA_PverTaxon1A_085 <- glPca(PverTaxon1A_085_genlight, parallel= TRUE) 
PCA_PverTaxon1A_085.df <- as.data.frame(PCA_PverTaxon1A_085$scores)
PC=1:10
pve_PverTaxon1 <- data.frame(PC, 100*PCA_PverTaxon1A_085$eig[1:10]/sum(PCA_PverTaxon1A_085$eig[1:10]))

ggplot(PCA_PverTaxon1A_085.df, aes(PC1, PC2, col= PverTaxon1A_metadata$locality)) + 
  geom_point(stroke= 0, size=8, alpha=0.5, show.legend = TRUE) +
  scale_colour_manual(values = c("#5C62D1", "#5C9FD1", "#5CBED1", "#66b66c", "#89af6d", "#7BB52B", "#F2C738", "#F39237", "#e68183", "firebrick1", "firebrick3", "firebrick4")) +
  coord_equal() + theme_bw() + theme(axis.text=element_text(size=16), axis.title=element_text(size=16)) +
  labs(x= paste0("PC1 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_085.eig.1.10..sum.PCA_PverTaxon1A_085.eig.1.10..[1], 3), "%)"),
       y = paste0("PC2 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_085.eig.1.10..sum.PCA_PverTaxon1A_085.eig.1.10..[2], 3), "%)"))

# PCA Missing data = 0.95
PCA_PverTaxon1A_095 <- glPca(PverTaxon1A_095_genlight, parallel= TRUE) 
PCA_PverTaxon1A_095.df <- as.data.frame(PCA_PverTaxon1A_095$scores)
PC=1:10
pve_PverTaxon1 <- data.frame(PC, 100*PCA_PverTaxon1A_095$eig[1:10]/sum(PCA_PverTaxon1A_095$eig[1:10]))

ggplot(PCA_PverTaxon1A_095.df, aes(PC1, PC2, col= PverTaxon1A_metadata$locality)) + 
  geom_point(stroke= 0, size=8, alpha=0.5, show.legend = TRUE) +
  scale_colour_manual(values = c("#5C62D1", "#5C9FD1", "#5CBED1", "#66b66c", "#89af6d", "#7BB52B", "#F2C738", "#F39237", "#e68183", "firebrick1", "firebrick3", "firebrick4")) +
  coord_equal() + theme_bw() + theme(axis.text=element_text(size=16), axis.title=element_text(size=16)) +
  labs(x= paste0("PC1 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_095.eig.1.10..sum.PCA_PverTaxon1A_095.eig.1.10..[1], 3), "%)"),
       y = paste0("PC2 (", signif(pve_PverTaxon1$X100...PCA_PverTaxon1A_095.eig.1.10..sum.PCA_PverTaxon1A_095.eig.1.10..[2], 3), "%)"))

#### IBD slope ####

PverTaxon1A_mercator <- read.csv("lonlat_Pver.csv")

# Missing data 0.80

PverTaxon1A_genlight_mercator_080 <- PverTaxon1A_080_genlight
PverTaxon1A_genlight_mercator_080@ind.names <- PverTaxon1A_mercator$lonlat
PverTaxon1A_genlight_mercator_080@pop <- as.factor(PverTaxon1A_mercator$pop)
PverTaxon1A_genepop_mercator_080 <- gl2genepop(PverTaxon1A_genlight_mercator_080)
write.table(PverTaxon1A_genepop_mercator_080, file = "PverTaxon1A_genepop_080.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#sed 's/pop.*_//' PverTaxon1A_genepop_080.txt > PverTaxon1A_genepop_080_2.txt

PverTaxon1A_IBD_080 <- ibd(inputFile= "PverTaxon1A_genepop_080_2.txt", 
                             outputFile = "PverTaxon1A_genepop_080_out.txt", 
                             statistic='a', dataType='Diploid', settingsFile = '', 
                             geographicScale='1D', verbose = interactive())

Pver_IBD_080 <- read.csv("IBD_080.csv")
ggplot() + 
  geom_point(data=Pver_IBD_080, aes(x =GeoDist, y =GenDist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Pver_IBD_080, aes(x = GeoDist, y = GenDist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Geographic distance (m)") +
  stat_regline_equation(label.x = 0, label.y = 0.55)

# Missing data 0.85

PverTaxon1A_genlight_mercator_085 <- PverTaxon1A_085_genlight
PverTaxon1A_genlight_mercator_085@ind.names <- PverTaxon1A_mercator$lonlat
PverTaxon1A_genlight_mercator_085@pop <- as.factor(PverTaxon1A_mercator$pop)
PverTaxon1A_genepop_mercator_085 <- gl2genepop(PverTaxon1A_genlight_mercator_085)
write.table(PverTaxon1A_genepop_mercator_085, file = "PverTaxon1A_genepop_085.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#sed 's/pop.*_//' PverTaxon1A_genepop_085.txt > PverTaxon1A_genepop_085_2.txt

PverTaxon1A_IBD_085 <- ibd(inputFile= "PverTaxon1A_genepop_085_2.txt", 
                           outputFile = "PverTaxon1A_genepop_085_out.txt", 
                           statistic='a', dataType='Diploid', settingsFile = '', 
                           geographicScale='1D', verbose = interactive())

Pver_IBD_085 <- read.csv("IBD_085.csv")
ggplot() + 
  geom_point(data=Pver_IBD_085, aes(x =GeoDist, y =GenDist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Pver_IBD_085, aes(x = GeoDist, y = GenDist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Geographic distance (m)") +
  stat_regline_equation(label.x = 0, label.y = 0.55)

# Missing data 0.95

PverTaxon1A_genlight_mercator_095 <- PverTaxon1A_095_genlight
PverTaxon1A_genlight_mercator_095@ind.names <- PverTaxon1A_mercator$lonlat
PverTaxon1A_genlight_mercator_095@pop <- as.factor(PverTaxon1A_mercator$pop)
PverTaxon1A_genepop_mercator_095 <- gl2genepop(PverTaxon1A_genlight_mercator_095)
write.table(PverTaxon1A_genepop_mercator_095, file = "PverTaxon1A_genepop_095.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#sed 's/pop.*_//' PverTaxon1A_genepop_095.txt > PverTaxon1A_genepop_095_2.txt

PverTaxon1A_IBD_095 <- ibd(inputFile= "PverTaxon1A_genepop_095_2.txt", 
                           outputFile = "PverTaxon1A_genepop_095_out.txt", 
                           statistic='a', dataType='Diploid', settingsFile = '', 
                           geographicScale='1D', verbose = interactive())

Pver_IBD_095 <- read.csv("IBD_095.csv")
ggplot() + 
  geom_point(data=Pver_IBD_095, aes(x =GeoDist, y =GenDist), size=2, shape=16, alpha=1) + 
  geom_smooth(data=Pver_IBD_095, aes(x = GeoDist, y = GenDist), method = lm, colour="black", size=0.5) + 
  ylab("Genetic distance (Rousset's a)") +
  xlab("Geographic distance (m)") +
  stat_regline_equation(label.x = 0, label.y = 0.55)

#### NeEstimator ####

PverTaxon1A_metadata_northsouth1 <- PverTaxon1A_metadata
PverTaxon1A_metadata_northsouth1$northsouth <- PverTaxon1A_metadata_northsouth1$EcoClusterID
PverTaxon1A_metadata_northsouth1$northsouth <- with(PverTaxon1A_metadata_northsouth1, factor(northsouth, levels = c('Flinders', 'Inshore Central', 'Inshore Central GBR', 'Offshore Central', 'Offshore Central GBR', 'Offshore South GBR', 'Offshore North GBR', 'Torres Strait'), labels = c('south', 'south', 'south', 'south', 'south', 'south', 'north', 'north')))

PverTaxon1A_metadata_northsouth2 <- PverTaxon1A_metadata
PverTaxon1A_metadata_northsouth2$northsouth <- PverTaxon1A_metadata_northsouth2$EcoClusterID
PverTaxon1A_metadata_northsouth2$northsouth <- with(PverTaxon1A_metadata_northsouth2, factor(northsouth, levels = c('Flinders', 'Inshore Central', 'Inshore Central GBR', 'Offshore Central', 'Offshore Central GBR', 'Offshore South GBR', 'Offshore North GBR', 'Torres Strait'), labels = c('south', 'north', 'north', 'north', 'north', 'south', 'north', 'north')))

# Missing data 080
PverTaxon1A_genlight_080_Ne <- PverTaxon1A_080_genlight
PverTaxon1A_genlight_080_Ne@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_080_Ne@pop <- as.factor(PverTaxon1A_metadata_northsouth1$northsouth)
PverTaxon1A_Ne_genepop_080_northsouth <- gl2genepop(PverTaxon1A_genlight_080_Ne)
write.table(PverTaxon1A_Ne_genepop_080_northsouth, file = "PverTaxon1A_Ne_genepop_080_northsouth1.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

PverTaxon1A_genlight_080_Ne2 <- PverTaxon1A_080_genlight
PverTaxon1A_genlight_080_Ne2@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_080_Ne2@pop <- as.factor(PverTaxon1A_metadata_northsouth2$northsouth)
PverTaxon1A_Ne_genepop_080_northsouth2 <- gl2genepop(PverTaxon1A_genlight_080_Ne2)
write.table(PverTaxon1A_Ne_genepop_080_northsouth2, file = "PverTaxon1A_Ne_genepop_080_northsouth2.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

# Missing data 085
PverTaxon1A_genlight_085_Ne <- PverTaxon1A_085_genlight
PverTaxon1A_genlight_085_Ne@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_085_Ne@pop <- as.factor(PverTaxon1A_metadata_northsouth1$northsouth)
PverTaxon1A_Ne_genepop_085_northsouth <- gl2genepop(PverTaxon1A_genlight_085_Ne)
write.table(PverTaxon1A_Ne_genepop_085_northsouth, file = "PverTaxon1A_Ne_genepop_085_northsouth1.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

PverTaxon1A_genlight_085_Ne2 <- PverTaxon1A_085_genlight
PverTaxon1A_genlight_085_Ne2@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_085_Ne2@pop <- as.factor(PverTaxon1A_metadata_northsouth2$northsouth)
PverTaxon1A_Ne_genepop_085_northsouth2 <- gl2genepop(PverTaxon1A_genlight_085_Ne2)
write.table(PverTaxon1A_Ne_genepop_085_northsouth2, file = "PverTaxon1A_Ne_genepop_085_northsouth2.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

# Missing data 095
PverTaxon1A_genlight_095_Ne <- PverTaxon1A_095_genlight
PverTaxon1A_genlight_095_Ne@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_095_Ne@pop <- as.factor(PverTaxon1A_metadata_northsouth1$northsouth)
PverTaxon1A_Ne_genepop_095_northsouth <- gl2genepop(PverTaxon1A_genlight_095_Ne)
write.table(PverTaxon1A_Ne_genepop_095_northsouth, file = "PverTaxon1A_Ne_genepop_095_northsouth1.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

PverTaxon1A_genlight_095_Ne2 <- PverTaxon1A_095_genlight
PverTaxon1A_genlight_095_Ne2@ind.names <- PverTaxon1A_metadata$Sample_name
PverTaxon1A_genlight_095_Ne2@pop <- as.factor(PverTaxon1A_metadata_northsouth2$northsouth)
PverTaxon1A_Ne_genepop_095_northsouth2 <- gl2genepop(PverTaxon1A_genlight_095_Ne2)
write.table(PverTaxon1A_Ne_genepop_095_northsouth2, file = "PverTaxon1A_Ne_genepop_095_northsouth2.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#### Fst ####

get_upper_tri = function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}

# Missing data 080
PverTaxon1A_080_genlight@pop <- as.factor(PverTaxon1A_metadata$locality)
Pver_fst_080 <- gl.fst.pop(PverTaxon1A_080_genlight)
Pver_fst_080[Pver_fst_080<0] <- 0
Pver_fst_080 <- as.matrix(as.dist(Pver_fst_080))
Pver_fst_080_tri <- get_upper_tri(Pver_fst_080)
Pver_fst_080_melted <- melt(Pver_fst_080_tri, na.rm = TRUE)

ggplot(data = Pver_fst_080_melted, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0.075, limit = c(0,0.15), space = "Lab", name="Fst") +
  theme_minimal()
# Missing data 085
PverTaxon1A_085_genlight@pop <- as.factor(PverTaxon1A_metadata$locality)
Pver_fst_085 <- gl.fst.pop(PverTaxon1A_085_genlight)
Pver_fst_085[Pver_fst_085<0] <- 0
Pver_fst_085 <- as.matrix(as.dist(Pver_fst_085))
Pver_fst_085_tri <- get_upper_tri(Pver_fst_085)
Pver_fst_085_melted <- melt(Pver_fst_085_tri, na.rm = TRUE)

ggplot(data = Pver_fst_085_melted, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0.075, limit = c(0,0.15), space = "Lab", name="Fst") +
  theme_minimal()

# Missing data 095
PverTaxon1A_095_genlight@pop <- as.factor(PverTaxon1A_metadata$locality)
Pver_fst_095 <- gl.fst.pop(PverTaxon1A_095_genlight)
Pver_fst_095[Pver_fst_095<0] <- 0
Pver_fst_095 <- as.matrix(as.dist(Pver_fst_095))
Pver_fst_095_tri <- get_upper_tri(Pver_fst_095)
Pver_fst_095_melted <- melt(Pver_fst_095_tri, na.rm = TRUE)

ggplot(data = Pver_fst_095_melted, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0.075, limit = c(0,0.15), space = "Lab", name="Fst") +
  theme_minimal()

# Heat map fst values differences among datasets
combined_data <- merge(Pver_fst_080_melted, Pver_fst_085_melted, by = c("Var1", "Var2"), suffixes = c("_080", "_085"))
combined_data$fst_diff <- combined_data$value_080 - combined_data$value_085
populations <- unique(c(combined_data$Var1, combined_data$Var2))
fst_diff_matrix <- matrix(NA, nrow = length(populations), ncol = length(populations))
rownames(fst_diff_matrix) <- populations
colnames(fst_diff_matrix) <- populations
for (i in 1:nrow(combined_data)) {
  fst_diff_matrix[combined_data$Var1[i], combined_data$Var2[i]] <- combined_data$fst_diff[i]
  fst_diff_matrix[combined_data$Var2[i], combined_data$Var1[i]] <- combined_data$fst_diff[i]  # Ensure symmetry
}
fst_diff_matrix_tri <- get_upper_tri(fst_diff_matrix)
fst_diff_melted <- melt(fst_diff_matrix_tri, na.rm = TRUE)

ggplot(fst_diff_melted, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "black")+
  scale_fill_gradient2(low = "#66CCCC", high = "#FF9999", mid = "beige", 
                       midpoint = 0, limit = c(-0.06,0.06), space = "Lab", name="Fst") +
  theme_minimal()

combined_data <- merge(Pver_fst_080_melted, Pver_fst_095_melted, by = c("Var1", "Var2"), suffixes = c("_080", "_095"))
combined_data$fst_diff <- combined_data$value_080 - combined_data$value_095
populations <- unique(c(combined_data$Var1, combined_data$Var2))
fst_diff_matrix <- matrix(NA, nrow = length(populations), ncol = length(populations))
rownames(fst_diff_matrix) <- populations
colnames(fst_diff_matrix) <- populations
for (i in 1:nrow(combined_data)) {
  fst_diff_matrix[combined_data$Var1[i], combined_data$Var2[i]] <- combined_data$fst_diff[i]
  fst_diff_matrix[combined_data$Var2[i], combined_data$Var1[i]] <- combined_data$fst_diff[i]  # Ensure symmetry
}
fst_diff_matrix_tri <- get_upper_tri(fst_diff_matrix)
fst_diff_melted <- melt(fst_diff_matrix_tri, na.rm = TRUE)

ggplot(fst_diff_melted, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "black")+
  scale_fill_gradient2(low = "#66CCCC", high = "#FF9999", mid = "beige", 
                       midpoint = 0, limit = c(-0.06,0.06), space = "Lab", name="Fst") +
  theme_minimal()

