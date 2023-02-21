# Basic3 No.3
# Stan and Hi-Weibull distribution

# setting libraries (rstan and ggmcmc)
library(rstan)
library(ggmcmc)

# settings (number of data)
N<-100

# settings (dimension and matrix)
y<-dim(N)
z1<-dim(N)
MZ<-matrix(0,N,2) # MZ[,1], MZ[,2]

# settings (m and eta)
m<-dim(N)
eta<-dim(N)

#------------------------------------------------------------------------

# settings (parameters for simulation data)
a1<-2.5 # for eta
p1<-0.5 # for eta, MZ[,1]
p2<-2.0 # for eta, MZ[,2]
a2<-3.5 # for m
b<-2.0  # for m, z1

# sample(): random sampling (range: 1 - 3)
z1<-sample(c(1,2,3),size=N,replace=TRUE)

# discrete uniform random numbers
MZ[,1]<-runif(N,0,10)

# sample(): random sampling (range: 1.0 - 4.5)
MZ[,2]<-sample(c(1.0,1.5,2.0,2.5,3.0,4.0,4.5),size=N,replace=TRUE)

# generate simulation data
for(i in 1:N){
  eta[i]<-rgamma(1,a1,exp(-(p1*MZ[i,1]+p2*MZ[i,2])))
  m[i]<-rgamma(1,a2,b*z1[i])
  y[i]<-rweibull(1,m[i],eta[i])
}

# set frame data (from simulation data)
DATA<-data.frame(y,z1,MZ)

# output *.csv file
write.csv(x=DATA,file="data_Basic3_no3.csv")

# read *.csv file
rDATA<-read.csv("data_Basic3_no3.csv")

# set list data (from rDATA (=frame data))
DATA_S<-list(N=nrow(rDATA),Y=rDATA$y,Z_m=rDATA$z1,ZZ_1=rDATA$X1,ZZ_2=rDATA$X2)

#------------------------------------------------------------------------

# run MCMC (Markov chain Monte Carlo methods) on stan library
fit<-stan(file="Basic3_no3_stan_Hi-Weibull.stan",data=DATA_S,seed=1234,chains=4,iter=2000)
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