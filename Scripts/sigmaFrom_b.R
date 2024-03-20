# Script to estimage sigma from effective or census density and IBD slope

# De: effective density
# b: isolation by distance slope
# b_low: lower bound 95% CI around b
# b_high: higher bound 95% CI around b
# dims: number of dimensions (1 or 2)

sigmaFrom_b <- function(De, b, b_high, b_low, dims){
  if(dims==1){
    sigma <- sqrt(1/(4*De*b)) 
    sigma_low <- sqrt(1/(4*De*b_low)) 
    sigma_high <- sqrt(1/(4*De*b_high)) 
  }
  if(dims==2){
    sigma <- sqrt(1/(pi*4*De*b)) 
    sigma_low <- sqrt(1/(pi*4*De*b_low)) 
    sigma_high <- sqrt(1/(pi*4*De*b_high)) 
  }
  return(list(sigma=sigma, sigma_low=sigma_low, sigma_high=sigma_high))
}

NbFrom_b <- function(b, b_high, b_low){
    Nb <- 1/b 
    Nb_low <- 1/b_low
    Nb_high <- 1/b_high
  }
  return(list(Nb=Nb, Nb_low=Nb_low, Nb_high=Nb_high))
}

# Stylophora pistillata
De_Spis=0.001774249
b_Spis=0.00316421
b_low_Spis=0.0021645
b_high_Spis=0.00416968
dims_Spis=2

sigma_Spis <- sigmaFrom_b(De_Spis, b_Spis, b_low_Spis, b_high_Spis, dims_Spis)
Nb_Spis <- NbFrom_b(b_Spis, b_low_Spis, b_high_Spis)

# Pocillopora verucosa
De_Pver=0.0201638
b_Pver=0.0000000156392
b_low_Pver=0.00000000701597
b_high_Pver=0.000000024611
dims_Pver=1

sigma_Pver <- sigmaFrom_b(De_Pver, b_Pver, b_low_Pver, b_high_Pver, dims_Pver)
Nb_Pver <- NbFrom_b(b_Pver, b_low_Pver, b_high_Pver)
