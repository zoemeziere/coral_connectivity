# Estimating sigma and Nb for Stylophora pistillata Taxon 1
# Riginos, April 2024

library(rethinking)
setwd("/Users/zoemeziere/Documents/PhD/Chapter2_analyses/SpisTaxon1/IBD/CalculatingSigmaWithError")

# Roadmap
# 1 - De: Get priors from census counts and LDNe estimates
# 2- IBD slope: estimate distributions from GenePop outputs 
# 3 - Build generative models to predict sigma, neighborhood, etc

# Functions ---------------------------------------------------------------

# Find approximate alpha and beta parameters for a gamma distribution based on
# observing three quantiles
# Based on post below  - many thanks to "Sextus Empiricus"
# https://stats.stackexchange.com/questions/596388/fit-gamma-distribution-based-on-median-interquartile-range

# fit_pars() returns the fit of the supplied parameters, observed quantile values, and quantile probability thresholds
# approx_gamma_pars() returns the approximate shape and scale parameters based on Nelder and Mead (1965) approximation
# par is the starting  distribution parameter values

fit_gamma_pars = function(par, obs_quantiles, p_thresholds=c(0.025,0.5,0.975)) {
  p_quantiles = pgamma(obs_quantiles, shape = par[1], scale = par[2])
  statistic = max(abs(p_quantiles - p_thresholds))
  return(statistic)
} 
approx_gamma_pars<-function(par = NULL, obs_quantiles, p_thresholds=c(0.025,0.5,0.975)) {
  if (is.null(par)) {
    mean_obs <- mean(obs_quantiles)
    var_obs <- var(obs_quantiles)
    shape_init <- (mean_obs^2) / var_obs
    scale_init <- var_obs / mean_obs
    par <- c(shape_init, scale_init)
  }
  params<-optim(par, 
                fit_gamma_pars, 
                par,
                obs_quantiles,
                p_thresholds)$par
  return(params)
}

fit_lnorm_pars = function(par, obs_quantiles, p_thresholds=c(0.025,0.5,0.975)) {
  p_quantiles = plnorm(obs_quantiles, meanlog = par[1], sdlog = par[2])
  statistic = max(abs(p_quantiles - p_thresholds))
  return(statistic)
} 
approx_lnorm_pars<-function(par = c(0,1), obs_quantiles, p_thresholds=c(0.025,0.5,0.975)) {
  if (is.null(par)) {
    mean_obs <- mean(obs_quantiles)
    var_obs <- var(obs_quantiles)
    shape_init <- (mean_obs^2) / var_obs
    scale_init <- var_obs / mean_obs
    par <- c(shape_init, scale_init)
  }
  params<-optim(par, 
                fit_lnorm_pars, 
                par,
                obs_quantiles,
                p_thresholds)$par
  return(params)
}

# Construct priors for density -------------------------------------------

# CENSUS density 
# From census_densities_counts_abundance.R, we have obtained posterior distributions for 
# a) poisson lambda describing all stylophora (per 288m2): stylo_counts_post
# b) binomial p describing proportion of Tax1: stylo_proportions_post
stylo_proportions_post<-readRDS("./stylo_proportions_post.RDS")
stylo_counts_post<-readRDS("./stylo_counts_post.RDS")

NC_Spis<-stylo_counts_post$lambda*stylo_proportions_post$p
hist(NC_Spis)

DNC_Spis<-stylo_counts_post$lambda*stylo_proportions_post$p/288 

# LDNE density - assume gamma distribution b/c upper tail can be large
Ne_estimates <- read.csv("./Spis_Ne_pop.csv") # estimates of Ne distributions for 8 pops

# Want to create a posterior distribution of Ne representing all populations
# We will simulate posteriors based on the returned values
# Then get density

NE_Spis<-list()
DNE_Spis<-list()

for(r in 1:nrow(Ne_estimates)) {
  Ne<-Ne_estimates[r,"Ne"]/0.83 
  Ne_low<-Ne_estimates[r,"Ne_low"]/0.83
  Ne_high<-Ne_estimates[r,"Ne_high"]/0.83
  shape<-approx_gamma_pars(obs_quantiles=c(Ne_low, Ne, Ne_high))[1]
  scale<-approx_gamma_pars(obs_quantiles=c(Ne_low, Ne, Ne_high))[2]
  NE_Spis[[r]] <-rgamma(1000, shape=shape, scale=scale)
  hist(NE_Spis[[r]], main = paste(r))
  DNE_Spis[[r]] <- NE_Spis[[r]]/Ne_estimates[r, "Area_coral"]
  hist(DNE_Spis[[r]], main = paste(r))
}
 
DNE_Spis<-unlist(DNE_Spis) 
hist(DNE_Spis)

# Slope - estimating gamma function for prior -----------------------------
# Using slope output from GenePop
beta_quantiles_Spis <- c(0.0021645, 0.00316421, 0.00416968)
beta_mean_Spis<-approx_lnorm_pars(obs_quantiles=c(beta_quantiles_Spis))[[1]]
beta_variance_Spis<-approx_lnorm_pars(obs_quantiles=c(beta_quantiles_Spis))[[2]]

# Create generative Bayesian model to simulate sigma ----------------------
# Trying to simulate sigma calculations from isolation by distance slopes

# Simulate data 
numb_sims = 1000
beta_Spis<-rlnorm(numb_sims, beta_mean_Spis, beta_variance_Spis)
hist(beta_Spis, bin=50)

sigma_DC_Spis<-sqrt(1/(4*pi*DNC_Spis*beta_Spis)) 
sigma_DN_Spis<-sqrt(1/(4*pi*DNE_Spis*beta_Spis))
hist(sigma_DC_Spis)
hist(sigma_DN_Spis)

Neighborhood_NC_Spis<-4*pi*DNC_Spis*sigma_DC_Spis^2 
Neighborhood_NE_Spis<-4*pi*DNE_Spis*sigma_DN_Spis^2

sigma_DC_Spis.df <- as.data.frame(sigma_DC_Spis)
sigma_DN_Spis.df  <- as.data.frame(sigma_DN_Spis)