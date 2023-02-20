# Basic3 No.4
# Stan and SV model

# setting libraries (rstan and ggmcmc)
library(rstan)
library(ggmcmc)

# settings (number of data)
N<-100

# settings (dimensions)
Y<-dim(N)
S<-dim(N)
eps<-dim(N)

# settings (parameters for simulation data)
a<-0.4
b<-0.2
mu<-0.2
sigma_del<-1.0
sigma_eps<-1.0

# generate random data
Y[1]<-0.001
S[1]<-rnorm(1,mu,b/sqrt(1-a^2))
del<-rnorm(N,0,sigma_del)
eps<-rnorm(N,0,sigma_eps)

# generate simulation data
for(i in 2:N){
  S[i]<-mu+a*(S[i-1]-mu)+b*del[i]
  Y[i]<-exp(S[i]/2)*eps[i]
}

# plot
plot(Y,type="l")

#-----Bayes-----

# set frame data (from simulation data)
DATA<-data.frame(Y)

# set list data (from DATA (=frame data))
DATA_S<-list(N=nrow(DATA),Y=DATA$Y)

# run MCMC (Markov chain Monte Carlo methods) on stan library
fit<-stan(file="Basic3_no4_stan_SV_model.stan",data=DATA_S,seed=1234)

# get MCMC results from stan library
ms<-rstan::extract(fit)
print( summary(fit) )

# plot
windows()
par(mfcol=c(3,1))
plot(ms$a,type="l")
plot(ms$b,type="l")
plot(ms$mu,type="l")

# plot
windows()
par(mfcol=c(1,1))
plot(ms$lp_,type="l")

# plot (a, b, and mu)
windows()
par(mfcol=c(3,1))
#
mean(ms$a)
quantile(ms$a,probs=c(0.025,0.975))
plot(density(ms$a))
#
mean(ms$b)
quantile(ms$b,probs=c(0.025,0.975))
plot(density(ms$b))
#
mean(ms$mu)
quantile(ms$mu,probs=c(0.025,0.975))
plot(density(ms$mu))