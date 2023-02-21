# Modeling with the "BUGS" language

## Use "rjags"
library(rjags)
n.t <- 50 # Number of periods observed
n.obs <- 4 # Number of replicate measurements per period

## Observed value
Y <- t(matrix(c(33, 37, 29, 34, 38, 36, 37, 26, 29, 30,
  20, 31, 32, 31, 31, 28, 26, 25, 21, 20,
  25, 35, 27, 27, 25, 27, 29, 26, 20, 23,
  18, 22, 20, 32, 25, 24, 25, 19, 16, 16,
  17, 18, 12, 15, 13, 19, 11, 12, 9, 11,
  38, 34, 30, 28, 42, 37, 45, 29, 29, 35,
  28, 31, 25, 28, 34, 27, 30, 24, 28, 24,
  18, 41, 25, 27, 24, 22, 28, 23, 28, 26,
  24, 22, 28, 27, 24, 18, 21, 20, 19, 20,
  18, 19, 14, 16, 13, 21, 13, 13, 14, 10,
  34, 31, 27, 30, 40, 38, 42, 31, 32, 27,
  22, 25, 28, 36, 36, 23, 28, 26, 25, 20,
  24, 44, 23, 30, 24, 25, 28, 26, 25, 18,
  22, 25, 26, 19, 25, 19, 26, 16, 20, 18,
  22, 15, 16, 19, 17, 19, 10, 11, 10, 13,
  34, 35, 29, 33, 32, 33, 44, 31, 27, 28,
  25, 33, 25, 30, 36, 24, 30, 27, 24, 22,
  24, 32, 26, 29, 21, 27, 30, 24, 26, 22,
  17, 20, 22, 24, 23, 19, 29, 23, 20, 17,
  19, 18, 16, 14, 14, 18, 14, 11, 13, 12),
nrow = n.obs, byrow = TRUE))

## Model by BUGS
model.bugs <- "
var
  n.t,
  n.obs,
  Y[n.t, n.obs],
  N[n.t],
  lambda[n.t],
  exp.lambda[n.t],
  p, tau, sigma;

model {
  ## data model
  for (t in 1:n.t) {
    for (i in 1:n.obs) {
      Y[t, i] ~ dbin(p, N[t]);
    }
    N[t] ~ dpois(exp(lambda[t]));
  }
  ## process model
  for (t in 2:n.t) {
    lambda[t] ~ dnorm(lambda[t - 1], tau);
  }
  ## prior distribution
  lambda[1] ~ dnorm(0, 1.0E-4);
  p ~ dbeta(1, 1);
  sigma ~ dunif(0, 100);
  tau <- 1 / (sigma * sigma);
  ## Compute exp(lambda)
  for (t in 1:n.t) {
    exp.lambda[t] <- exp(lambda[t]);
  }
}"
cat(model.bugs, file = "ex3.bug.txt")

## Initial value
inits <- list()
inits[[1]] <- list(p = 0.9, sigma = 1, N = rep(50, n.t),
  .RNG.name = "base::Mersenne-Twister",
  .RNG.seed = 1)
inits[[2]] <- list(p = 0.5, sigma = 3, N = rep(70, n.t),
  .RNG.name = "base::Mersenne-Twister",
  .RNG.seed = 2)
inits[[3]] <- list(p = 0.3, sigma = 5, N = rep(90, n.t),
  .RNG.name = "base::Mersenne-Twister",
  .RNG.seed = 3)

## Running JAGS
model <- jags.model("ex3.bug.txt",
  data = list(n.t = n.t, n.obs = n.obs, Y = Y),
  inits = inits, n.chains = 3, n.adapt = 1000)
update(model, 1000)
samp <- coda.samples(model,
  variable.names = c("exp.lambda", "sigma", "p"),
  n.iter = 20000, thin = 20)

## convergence diagnosis
gelman.diag(samp, multivariate = FALSE)

## Viewing results
summary(samp)

## View graph
library(ggplot2)
s <- summary(samp)$statistics
pos1 <- match("exp.lambda[1]", rownames(s))
explambda.mean <- s[pos1:(pos1 + n.t - 1), "Mean"]
d1 <- data.frame(t = rep(1:n.t, n.obs), Y = c(Y))
d2 <- data.frame(t = 1:n.t, Y.mean = apply(Y, 1, mean),
  N.mean = explambda.mean)
p <- ggplot(d2)
p + 
  geom_point(data = d1, aes(x = t, y = Y),
  colour = "black", size = 2.5, alpha = 0.5) +
  geom_line(aes(x = t, y = Y.mean),
  colour = "black", size = 1, linetype = 1) +
  geom_line(aes(x = t, y = N.mean),
  colour = "black", size = 1, linetype = 2) +
  xlab("Time") + ylab("Population size") +
  theme_classic(12, "Helvetica")
