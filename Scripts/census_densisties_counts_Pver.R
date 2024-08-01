# Riginos, April 2024
# Set working directory to this script
# Using Pocillopora verrucosa data from Zoe

library(tidyverse)
library(rethinking)
setwd("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/PverTaxon1A/IBD/CalculatingSigmaWithError")

# Roadmap -----------------------------------------------------------------
# Goal: To describe distributions related to the density of Pocillopora verrucosa from census data
# 1 - Estimate raw counts of all Pocillopora verrucosa 
# 3 - Use obtained posterior distribution as prior in sigma calculations 

# Read in files and prepare them ------------------------------------------

# Read in data
Pver_census_numbers <- read.csv("./census_numbers_Pver.csv") #read census numbers

# Consolidate to one data frame
Pver_census_numbers_grp <- 
  Pver_census_numbers %>% 
  group_by(EcoSiteID) %>%  
  summarise(count = n_distinct(Colony)) 

rm(Pver_census_numbers)

numb_sims<-1000 #make divisable by number of populations that are providing LDNe inputs

# Estimate raw counts (deal with sampled area later) -----------------------

# Model: density~Poisson(lambda), link is log, so likelihood: log(lambda) = alpha ; intercept only model

# picking a prior for alpha
curve( dlnorm( x , 3 , 1 ) , from=0 , to=100 , n=200 ) #looks weakly informative on log scale

counts <- list(counts = Pver_census_numbers_grp$count)

# intercept only model 
intercept_m <- ulam(
  alist( 
    counts ~ dpois( lambda ), 
    log(lambda) <- a, 
    a ~ dnorm( 3 , 1 )
  ), data=counts , chains=numb_sims/500 , log_lik=TRUE ) #increase number of chains to get 1000 post samples

precis(intercept_m ) # = posterior for intercept on log scale
exp(precis(intercept_m )$mean) #23.99993
exp(precis(intercept_m )$sd) #1.030818

#Posterior to be used as prior in sigma calculation
Pver_counts_post<-extract.samples(intercept_m) #n= flag not working
saveRDS(Pver_counts_post,"./Zoe_files/PosteriorPredictedDistributions/Pver_counts_post.RDS")

Pver_counts_post <- readRDS("./Pver_counts_post.RDS")

#Go to dispersal_modeling_Pver.R   