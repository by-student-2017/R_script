# Basic3 No.3
# Stan and Hi-Weibull distribution

# select data
# (1:make random data, 2: read *.csv file)
SW<-1

# setting libraries (rstan and ggmcmc)
library(rstan)
library(ggmcmc)

# settings (number of data)
N<-100

# settings (dimension and matrix)
y<-dim(N)
zm<-dim(N)
MZ<-matrix(0,N,3) # MZ[,1], MZ[,2], MZ[,3]

# settings (m and eta)
m<-dim(N)
eta<-dim(N)

#------------------------------------------------------------------------
# make random data
if(SW==1){

  # settings (parameters for simulation data)
  a1<-2.5 # for eta
  p1<-0.5 # for eta, MZ[,1]
  p2<-1.2 # for eta, MZ[,2]
  p3<-2.0 # for eta, MZ[,3]
  a2<-3.5 # for m
  b<-2.0  # for m, zm

  # sample(): random sampling (range: 1 - 3)
  zm<-sample(c(1,2,3),size=N,replace=TRUE)

  # discrete uniform random numbers
  MZ[,1]<-runif(N,0,10)

  # sample(): random sampling (range: 1.0 - 4.5)
  MZ[,2]<-sample(c(1.0,1.5,2.0,2.5,3.0,4.0,4.5),size=N,replace=TRUE)

  # sample(): random sampling (range: 1.0 - 9.0)
  MZ[,3]<-sample(c(1.0,3.0,4.0,5.0,6.0,8.0,9.0),size=N,replace=TRUE)

  # generate simulation data
  for(i in 1:N){
    eta[i]<-rgamma(1,a1,exp(-(p1*MZ[i,1]+p2*MZ[i,2]+p3*MZ[i,3])))
    m[i]<-rgamma(1,a2,b*zm[i])
    y[i]<-rweibull(1,m[i],eta[i])
  }

  # set frame data (from simulation data)
  DATA<-data.frame(y,zm,MZ)

  # output *.csv file
  write.csv(x=DATA,file="data_Basic3_no3_sw_v2.csv")

} # end "if(SW==1){"
#------------------------------------------------------------------------
# read *.dat from "C:\Users\username\Documents\data_Basic3_no3_sw_v2.csv"
if(SW==2){

  # read *.csv file
  DATA<-read.csv("data_Basic3_no3_sw_v2.csv")

} # end "if(SW==2){"
#------------------------------------------------------------------------

# set list data (from DATA)
DATA_S<-list(N=nrow(DATA),Y=DATA$y,Z_m=DATA$zm,ZZ_1=DATA$X1,ZZ_2=DATA$X2,ZZ_3=DATA$X3)

# run MCMC (Markov chain Monte Carlo methods) on stan library
fit<-stan(file="Basic3_no3_stan_Hi-Weibull_sw_v2.stan",data=DATA_S,seed=1234,chains=4,iter=2000)
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
