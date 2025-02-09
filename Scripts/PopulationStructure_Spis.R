###Script to perform population structure analyses on S. pistillata dataset

library(adegenet)
library(dartR)
library(tidyr)
library(ggplot2)
library(vegan)

###Genomic data and metadata
StyloTaxon1_genlight <- gl.read.vcf("StyloTaxon1_SF095_LD.vcf")
StyloTaxon1_metadata <- read.csv("StyloTaxon1_metadata.csv", header = TRUE) %>% arrange(Sample_name)
StyloTaxon1_metadata$locality <- factor(StyloTaxon1_metadata$locality, levels = c("Lizard", "Moore", "Pelorus", "Davies", "Chicken", "Little Broadhurst", "Heron", "Lady Musgrave"))
StyloTaxon1_coordinates <- as.data.frame(cbind("lon" = StyloTaxon1_metadata$decimalLongitude, "lat" = StyloTaxon1_metadata$decimalLatitude))
reefs_coords <- read.csv("reefs_coords.csv", header = TRUE)

###Principal Components Analyses
PCA_StyloTaxon1 <- glPca(StyloTaxon1_genlight, parallel= TRUE) 
PCA_StyloTaxon1.df <- as.data.frame(PCA_StyloTaxon1$scores)
PC=1:10
pve_StyloTaxon1 <- data.frame(PC, 100*PCA_StyloTaxon1$eig[1:10]/sum(PCA_StyloTaxon1$eig[1:10]))

#PC loadings
barplot(PCA_StyloTaxon1$eig, ylim = c(0,6), ylab = " Percentage of variance explained", xlab = "Principal Component axis")

#Procrustes transformation
p<-procrustes(as.matrix(cbind(PCA_StyloTaxon1.df$PC1,PCA_StyloTaxon1.df$PC2)),
              as.matrix(cbind(StyloTaxon1_metadata$decimalLongitude,StyloTaxon1_metadata$decimalLatitude)),
              translation=TRUE,dilation=TRUE)
#PCA plot using PC1-2 plot 
ggplot(as.data.frame(p$X), aes(Dim1, Dim2)) + 
  geom_point(stroke= 0, size=6, alpha=0.5, show.legend = TRUE, aes(col= StyloTaxon1_metadata$locality)) +
  scale_colour_manual(values = c("#F39237", "#F2C738", "#A2B52B", "#7BB52B", "#1F7D1E", "#5CD1C6", "#5CBED1", "#5C9FD1")) +
  coord_equal() + theme_bw() + theme(axis.text=element_text(size=10), axis.title=element_text(size=10)) +
  labs(x= paste0("PC1 (", signif(pve_StyloTaxon1$X100...PCA_StyloTaxon1.eig.1.10..sum.PCA_StyloTaxon1.eig.1.10..[1], 3), "%)"),
       y = paste0("PC2 (", signif(pve_StyloTaxon1$X100...PCA_StyloTaxon1.eig.1.10..sum.PCA_StyloTaxon1.eig.1.10..[2], 3), "%)"))

###ADMIXTURE
StyloTaxon1_K9_admix <- read.table("StyloTaxon1_SF095_LD.9.Q") %>%
  cbind(StyloTaxon1_metadata, StyloTaxon1_K9_admix) %>% 
  gather(StyloTaxon1_K9_admix, key="V", value="probK9", 25:33)

ggplot(StyloTaxon1_K9_admix, aes(factor(Sample_name), probK9, fill = factor(V))) +
  geom_col(size = 0.1) +
  scale_fill_manual(values = c("#5C9FD1", "#F2C738", "#F39237", "#7BB52B", "#A2B52B", "#1F7D1E", "#5CD1C6", "#5CBED1", "darkolivegreen")) +
  facet_grid(~fct_inorder(StyloTaxon1_metadata$locality), switch = "x", scales = "free", space = "free") +
  theme_minimal(base_size =10) + labs(title = "K=9", y = "Ancestry proportion", x = "") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(expand = expand_scale(add = 1)) +
  theme(
    panel.spacing.x = unit(0.1, "lines"),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    legend.position="none",
    plot.margin = unit(c(0, 0, 0, 0), "null"))  

