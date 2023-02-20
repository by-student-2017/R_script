# Basic3 No.2
# Stan and Weibull distribution

# setting libraries (rstan and ggmcmc)
library(rstan)
library(ggmcmc)

# settings (number of data)
N<-100

# settings (parameter m and eta for simulation data)
m<-2.5
eta<-5.0

# generate simulation data
#   random data from Weibull distribution
X<-rweibull(N,m,eta)

# set frame data (from simulation data)
DATA<-data.frame(X)

# set list data (from DATA (=frame data))
DATA_S<-list(N=nrow(DATA),X=DATA$X)

# run MCMC (Markov chain Monte Carlo methods) on stan library
fit<-stan(file="Basic3_no2_stan_Ewibull.stan",data=DATA_S,seed=1234,chains = 4,iter = 2000)
print( summary(fit) )

# get MCMC results from stan library
ms<-rstan::extract(fit)

# plot
windows()
par(mfcol=c(3,1))
plot(ms$m,type="l")
plot(ms$eta,type="l")
plot(ms$lp_,type="l")

# plot (m)
windows()
par(mfcol=c(2,1))
mean(ms$m)
quantile(ms$m,probs=c(0.025,0.975))
plot(density(ms$m))

# plot (eta)
mean(ms$eta)
quantile(ms$eta,probs=c(0.025,0.975))
plot(density(ms$eta))