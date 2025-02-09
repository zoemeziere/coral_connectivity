# Riginos, April 2024

library(tidyverse)
library(rethinking)

# Roadmap -----------------------------------------------------------------
# Goal: To describe distributions related to the density of Taxon1 Stylophora from census data
# 1 - Estimate raw counts of all Stylophora (deal with area calculation later)
# 2 - Estimate proportion of Tax1 relative to other taxa 
# 3 - Use obtained posterior distributions as priors in sigma calculations 

# Read in files and prepare them ------------------------------------------

# Read in data
Spis_census_numbers <- read.csv("census_numbers_Spis.csv") #read census numbers
Spis_proportions <- read.csv("Taxa_Spis_counts.csv") #different taxa proportions  

# Consolidate to one data frame
Spis_census_numbers_grp <- 
  Spis_census_numbers %>% 
  group_by(EcoSiteID) %>% 
  summarise(count = n_distinct(Colony)) 

rm(Spis_census_numbers)

Spis_proportions<- Spis_proportions %>%
  filter(complete.cases(.)) %>%
  rowwise() %>%
  mutate(totals = sum(c_across(starts_with("Taxon")), na.rm = T))

numb_sims<-8000 #make divisable by number of populations that are providing LDNe inputs

# 1 - Estimate raw counts (deal with sampled area later) -----------------------

# Model: density~Poisson(lambda), link is log, so likelihood: log(lambda) = alpha ; intercept only model

# picking a prior for alpha
curve( dlnorm( x , 3 , 1 ) , from=0 , to=100 , n=200 ) #looks weakly informative on log scale

counts <- list(counts = Spis_census_numbers_grp$count)

# intercept only model 
intercept_m <- ulam(
  alist( 
    counts ~ dpois( lambda ), 
    log(lambda) <- a, 
    a ~ dnorm( 3 , 1 )
  ), data=counts , chains=numb_sims/500 , log_lik=TRUE ) #increase number of chains to get 8000 post samples

precis(intercept_m ) # = posterior for intercept on log scale
exp(precis(intercept_m )$mean) # = 21.6 (mean posterior count on regular scale)
exp(precis(intercept_m )$sd) # = 1.02

#Posterior to be used as prior in sigma calculation
stylo_counts_post<-extract.samples(intercept_m) #n= flag not working
saveRDS(stylo_counts_post, "stylo_counts_post.RDS")

stylo_counts_post <- readRDS("stylo_counts_post.RDS")


# 2 - Estimate Tax1 proportions using genotyping results  ----------
# Model: Taxon1~binomial(totals,p), link is logit, so likelihood: logit(p) = alpha ; intercept only model

# picking a prior for p
p_vals<-rnorm(1000, 0, 1) #try an SD above 1 to see how the prior piles up on 0 & 1
p_vals_inv_logit <- inv_logit( p_vals ) 
dens( p_vals_inv_logit , adj=0.1 ) # this is the prior that gets evaluated after link

proportions <- list(N = Spis_proportions$totals,
                    Tax1= Spis_proportions$Taxon1)

# intercept only model 
intercept_tax1 <- ulam(
  alist( 
    Tax1 ~ dbinom(N, p), 
    logit(p) <- a, 
    a ~ dnorm( 0 , 1 )
  ), data=proportions , chains=numb_sims/500 , log_lik=TRUE )

precis(intercept_tax1)
inv_logit(0.48) #0.61: mean probability of being Tax1
inv_logit(0.11) #0.52: sd in probability of being Tax1

#Posterior to be used as prior in sigma calculation
stylo_proportions_post<-extract.samples(intercept_tax1 , n=numb_sims)
saveRDS(stylo_proportions_post, "stylo_proportions_post.RDS")

stylo_proportions_post <- readRDS("stylo_proportions_post.RDS")

rm(counts, intercept_m, intercept_tax1, proportions, 
   Spis_census_numbers_grp, Spis_proportions)

#Go to dispersal_modeling_Spis.R   
