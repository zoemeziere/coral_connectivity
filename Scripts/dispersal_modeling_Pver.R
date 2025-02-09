# Estimating sigma and Nb for Pocillopora verrucosa

library(rethinking)

# Roadmap
# 1 - De: Get priors from census counts and LDNe estimates
# 2 - IBD slope: estimate distributions from GenePop outputs 
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
approx_lnorm_pars<-function(par = c(mean(log(obs_quantiles)), sd(log(obs_quantiles))), obs_quantiles, p_thresholds=c(0.025,0.5,0.975)) {
  params<-optim(par, 
                fit_lnorm_pars, 
                par,
                obs_quantiles,
                p_thresholds)$par
  return(params)
}

# Construct priors for density -------------------------------------------

# CENSUS density 
# From census_densities_counts_abundance_Pver.R, we have obtained posterior distributions for 
# poisson lambda describing all Pocillopora verrucosa (per 6x48m site): Pver_counts_post
# We view each site as a transect of 0.5 x (12x48)m (quasi linear) and thus divide counts by 12x48 (=576) 
# to obtain linear densities per site
# Then we multiply by the coral-covered length of the GBR (=290000), then devide by the total length of the GRR (=2000000m)

Pver_counts_post<-readRDS("Pver_counts_post.RDS")

NC_Pver<-Pver_counts_post$lambda*Pver_counts_post$a
hist(NC_Pver)

DNC_Pver_site<-Pver_counts_post$lambda/576 
DNC_Pver<-DNC_Pver_site*290000/2000000 

# LDNE density - assume gamma distribution b/c upper tail can be large
# We will simulate posteriors based on the returned values
# Ne values already corrected for LD (Ne/0.83)
# Length of the GBR = 2000000 meters

NE_Pver<-list()
DNE_Pver<-list()

NE_quantiles_Pver <- c(28813.85542, 39796.62651, 64272.6506)
NE_mean_shape <- approx_gamma_pars(obs_quantiles=NE_quantiles_Pver)[1]
NE_mean_scale <- approx_gamma_pars(obs_quantiles=NE_quantiles_Pver)[2]
NE_Pver <-rgamma(1000, shape=NE_mean_shape, scale=NE_mean_shape)
hist(NE_Pver) 

DNE_Pver <- NE_Pver/2000000 
hist(DNE_Pver)

# Slope - estimating gamma function for prior -----------------------------
# Using slope output from GenePop
beta_quantiles_Pver <- c(7.02E-09, 1.56E-08, 2.46E-08)
beta_mean_Pver<-approx_lnorm_pars(obs_quantiles=beta_quantiles_Pver)[[1]]
beta_variance_Pver<-approx_lnorm_pars(obs_quantiles=beta_quantiles_Pver)[[2]]

# Create generative Bayesian model to simulate sigma ----------------------
# Trying to simulate sigma calculations from isolation by distance slopes

# Simulate data 
numb_sims = 1000
beta_Pver<-rlnorm(numb_sims, beta_mean_Pver, beta_variance_Pver)
hist(beta_Pver, breaks=100)

sigma_DC_Pver<-sqrt(1/(4*DNC_Pver*beta_Pver)) 
sigma_DN_Pver<-sqrt(1/(4*DNE_Pver*beta_Pver)) 
hist(sigma_DC_Pver)
hist(sigma_DN_Pver)

Neighborhood_NC_Pver<-4*DNC_Pver*sigma_DC_Pver^2 
Neighborhood_NE_Pver<-4*DNE_Pver*sigma_DN_Pver^2 

DispersalDistance_DC_Pver <- sigma_DC_Pver/sqrt(2) # Laplace kernel 
DispersalDistance_DN_Pver <- sigma_DN_Pver/sqrt(2) # Laplace kernel 
