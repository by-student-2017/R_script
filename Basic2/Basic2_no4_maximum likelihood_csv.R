# Basic2 No.4
# maximum likelihood
# Maximize log-likelihood function

# read *.csv file
DAT<-read.csv("data_Basic2_no4.csv")
print(DAT)

# settings from *.csv
x<-DAT$x
y<-DAT$y
z<-DAT$z

# show dimension of y
n<-length(y)
print("dimention of y")
print(n)

# setting (dimensions for range)
PP<-4 # number of parameters
theta<-dim(PP) # parameters to estimate (vector)

# maximum likelihood estimation
llf<-function(theta){
  ll<-0
  for(i in 1:n){
    # PP<-4 case
    ll1<-(-0.5)*log(2*pi*theta[4]^2)
     mu<-theta[1]*x[i]+theta[2]*z[i]+theta[3]
    ll2<-(-1)*(y[i]-mu)^2/(2*theta[4]^2)
     ll<-ll+(ll1+ll2)
    #
    # PP<-3 case
    #ll1<-(-0.5)*log(2*pi*theta[3]^2)
    # mu<-theta[1]*x[i]+theta[2]
    #ll2<-(-1)*(y[i]-mu)^2/(2*theta[3]^2)
    # ll<-ll+(ll1+ll2)
    #
    # PP<-2 case
    #ll1<-(-0.5)*log(2*pi*theta[2]^2)
    # mu<-theta[1]
    #ll2<-(-1)*(y[i]-mu)^2/(2*theta[2]^2)
    # ll<-ll+(ll1+ll2)
  }
  return(ll)
}

# c(): Combine Values into a Vector or List
# setting initial value
theta<-c(0.1,0.1,0.1,1.0) # PP<-4 case
#theta<-c(0.1,0.1,1.0) # PP<-3 case
#theta<-c(0.1,1.0) # PP<-2 case

# value obtained by substituting the initial value into the log-likelihood function
llf(theta)

#print(theta)

# maximum likelihood by L-BFGS-B method (#fnscale=-1 : Get max value)
res<-optim(theta,llf,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,-Inf,-Inf,0),upper=c(Inf,Inf,Inf,Inf),control=list(fnscale=-1)) # PP<-4 case
#res<-optim(theta,llf,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,-Inf,0),upper=c(Inf,Inf,Inf),control=list(fnscale=-1)) # PP<-3 case
#res<-optim(theta,llf,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,0),upper=c(Inf,Inf),control=list(fnscale=-1)) # PP<-2 case

print( summary(res) )

# AIC calculation
#print(res)
#res$par
#res$value
AIC<-(-2)*res$value+2*PP
print("AIC value")
print(AIC)
