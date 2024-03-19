###Script to perform population structure analyses on P. verrucosa dataset

###Required libraries
library(adegenet)
library(dartR)
library(tidyr)
library(ggplot2)
library(vegan)

###Genomic data and metadata
PverTaxon1A_genlight <- gl.read.vcf("PverTaxon1A_SF080_LD_nohyb.recode.vcf")
PverTaxon1A_metadata <- read.csv("PverTaxon1A_metadata.csv") %>% arrange(Sample_name)
PverTaxon1A_metadata$locality <- factor(PverTaxon1A_metadata$locality, levels = c("Flinders", "Lady Musgrave", "Heron", "Little Broadhurst", "Chicken", "Davies", "Pelorus", "Moore", "Lizard", "Masig", "Aukane", "Dungeness"))
PverTaxon1A_coordinates <- cbind("lon" = PverTaxon1A_metadata$decimalLongitude, "lat" = PverTaxon1A_metadata$decimalLatitude)

###Principal Components Analyses
PCA_PverTaxon1A <- glPca(PverTaxon1A_genlight, parallel= TRUE) 
PCA_PverTaxon1A.df <- as.data.frame(PCA_PverTaxon1A$scores)
PC=1:10
pve_PverTaxon1A <- data.frame(PC, 100*PCA_PverTaxon1A$eig[1:10]/sum(PCA_PverTaxon1A$eig[1:10]))

#PC loadings
barplot(PCA_PverTaxon1A$eig, ylim = c(0,6), ylab = " Percentage of variance explained", xlab = "Principal Component axis")

#PCA plot using PC1-2 plot 
ggplot(PCA_PverTaxon1A.df, aes(PC7, PC8, col= PverTaxon1A_metadata$locality)) + 
  geom_point(stroke= 0, size=6, alpha=0.5, show.legend = TRUE) +
  scale_colour_manual(values = c("#5C62D1", "#5C9FD1", "#5CBED1", "#5CD1C6", "#1F7D1E", "#7BB52B", "#A2B52B", "#F2C738", "#F39237", "#F27038", "#F25138", "#F23838")) +
  coord_equal() + theme_bw() + theme(axis.text=element_text(size=10), axis.title=element_text(size=10)) +
  labs(x= paste0("PC7 (", signif(pve_PverTaxon1A$X100...PCA_PverTaxon1A.eig.1.10..sum.PCA_PverTaxon1A.eig.1.10..[7], 3), "%)"),
       y = paste0("PC8 (", signif(pve_PverTaxon1A$X100...PCA_PverTaxon1A.eig.1.10..sum.PCA_PverTaxon1A.eig.1.10..[8], 3), "%)"))

###ADMIXTURE
PocilloTaxon1A_K2_admix <- read.table("PverTaxon1A_SF080_LD_nohyb.2.Q") %>%
  cbind(PverTaxon1A_metadata, PocilloTaxon1A_K2_admix) %>%
  gather(PocilloTaxon1A_K2_admix, key="V", value="probK2", 33:34)

ggplot(PocilloTaxon1A_K2_admix, aes(factor(Sample_name), probK2, fill = factor(V))) +
  geom_col(color = "gray", size = 0.1) +
  scale_fill_manual(values = c("#76bbd6", "#d0646d")) +
  facet_grid(~fct_inorder(PverTaxon1A_metadata$locality), switch = "x", scales = "free", space = "free") +
  theme_minimal(base_size =10) + labs(title = "K=2", y = "Ancestry proportion", x = "") +
  theme(axis.text.x = element_text(angle = 45)) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(expand = expand_scale(add = 1)) +
  theme(
    panel.spacing.x = unit(0.1, "lines"),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    legend.position="none",
    strip.text.x = element_text(angle=90),
    plot.margin = unit(c(0, 0, 0, 0), "null"))  

