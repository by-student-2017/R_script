# Loading the Rstan package
library(rstan)

# Set data to list type
abxdata <- list(Y=21,T=30)

# Run MCMC
fit1 <- stan("model1.stan",data=abxdata)

# Displays mean values of parameters, convergence judgment index (Rhat), etc.
summary(fit1)

# Density of the posterior distribution
stan_dens(fit1,pars="theta", separate_chains=T)

# Sampling trajectory
stan_trace(fit1,pars="theta",inc_warmup=T)

# Get the value of all samples
theta <- rstan::extract(fit1)$theta

# Prediction distribution
stan_ist(fit1,pars="y_pred",breaks=seq(0,30,1)
