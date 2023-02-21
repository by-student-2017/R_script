## Parameter estimation without using "gaussian_dlm_obs()"

## Using "Rstan"
library(rstan)

dlm2.stan <- "
data {
  int<lower=0> N;
  real y[N];
}

parameters {
  real theta[N];
  real<lower=0> sigma[2];
}

model {
  // data model
  for (t in 1:N) {
    y[t] ~ normal(theta[t], sigma[1]);
  }
  // process model
  for (t in 2:N) {
    theta[t] ~ normal(theta[t - 1], sigma[2]);
  }
  // prior distribution
  theta[1] ~ normal(0, 1.0e+6);
  sigma ~ uniform(0, 1.0e+6);
}

generated quantities {
  real V;
  real W;

  V <- sigma[1] * sigma[1];
  W <- sigma[2] * sigma[2];
}"

## Initial value
inits2 <- list(list(theta = rep(2000, length(Nile)),
  sigma = c(1, 1)),
  list(theta = rep(1000, length(Nile)),
  sigma = c(10, 10)),
  list(theta = rep(500, length(Nile)),
  sigma = c(100, 100)),
  list(theta = rep(100, length(Nile)),
  sigma = c(1000, 1000)))

## Run "Stan"
fit2 <- stan(model_code = dlm2.stan,
  data = list(N = length(Nile), y = c(Nile)),
  pars = c("V", "W"),
  chains = 4, iter = 10000, warmup = 2000, thin = 8,
  init = inits2, seed = 2)

## Viewing results
print(fit2)