# Basic3 No.1
# Stan and Normal distribution (Gauss distribution)

# setting libraries (rstan and ggmcmc)
library(rstan)
library(ggmcmc)

# settings (number of data)
N<-100

# settings (parameter mean(=mu) and sigma(=sig) for simulation data)
mu<-10
sig<-5.0

# generate simulation data
#   random data from Normal distribution (Gauss distribution)
X<-rnorm(N,mu,sig)

# set frame data (from simulation data)
DATA<-data.frame(X)

# set list data (from DATA (=frame data))
DATA_S<-list(N=nrow(DATA),X=DATA$X)

# run MCMC (Markov chain Monte Carlo methods) on stan library
fit<-stan(file="Basic3_no1_stan_Gauss.stan",data=DATA_S,seed=1234)
print( summary(fit) )

# get MCMC results from stan library
ms<-rstan::extract(fit)

# plot
windows()
par(mfcol=c(3,1))
plot(ms$mu,type="l")
plot(ms$sigma,type="l")
plot(ms$lp_,type="l")

# plot (mu)
windows()
par(mfcol=c(2,1))
mean(ms$mu)
quantile(ms$mu,probs=c(0.025,0.975))
plot(density(ms$mu))

# plot (sigma)
mean(ms$sigma)
quantile(ms$sigma,probs=c(0.025,0.975))
plot(density(ms$sigma))