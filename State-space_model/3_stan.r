# Modeling with "Stan"

## Using "Rstan" and "Nile" data
library(rstan)
data(Nile)

## Model by "Stan"
dlm1.stan <- "
data {
  int<lower=0> N;
  matrix[1, N] y;
}

transformed data {
  matrix[1, 1] F;
  matrix[1, 1] G;
  vector[1] m0;
  cov_matrix[1] C0;
  
  F[1, 1] <- 1;
  G[1, 1] <- 1;
  m0[1] <- 0;
  C0[1, 1] <- 1.0e+6;
}

parameters {
  real<lower=0> sigma[2];
}

transformed parameters {
  vector[1] V;
  cov_matrix[1] W;
  
  V[1] <- sigma[1] * sigma[1];
  W[1, 1] <- sigma[2] * sigma[2];
}

model {
  y ~ gaussian_dlm_obs(F, G, V, W, m0, C0);
  sigma ~ uniform(0, 1.0e+6);
}
"

## Initial values
inits <- list(list(sigma = c(1, 1)),
  list(sigma = c(10, 10)),
  list(sigma = c(100, 100)),
  list(sigma = c(1000, 1000)))

## Run "Stan"
fit1 <- stan(model_code = dlm1.stan,
  data = list(y = matrix(c(Nile), nrow = 1),
  N = length(Nile)),
  pars = c("V", "W"),
  chains = 4, iter = 10000, warmup = 2000, thin = 8,
  init = inits, seed = 1)

## Display results
print(fit1)

## Extract mean of parameters (error standard deviation)
V <- mean(extract(fit1)$V[, 1])
W <- mean(extract(fit1)$W[, 1, 1])

## Use result in "dlm"
library(dlm)
BuildLLM <- function(theta) {
  dlmModPoly(order = 1, dV = theta[1], dW = theta[2])
}

## Smoothing using "Stan" estimated error
mod.llm <- BuildLLM(c(V, W))
smooth.llm <- dlmSmooth(Nile, mod.llm)

## View graph
library(ggplot2)
d <- data.frame(Year = start(Nile)[1]:end(Nile)[1],
  Flow = c(Nile),
  Smooth = smooth.llm$s[-1])
p <- ggplot(d)
p + geom_point(aes(x = Year, y = Flow)) +
  geom_line(aes(x = Year, y = Flow)) +
  geom_line(aes(x = Year, y = Smooth), 
  colour = "gray35", linetype = 1, size = 1.2) +
  ylab(expression(paste("Flow (", 10^8, m^3, ")"))) +
  theme_classic(12, "Helvetica")
