# Basic2 No.2
# maximum likelihood
# Maximize log-likelihood function

# settings (number of cycles)
n<-30

# normal distribution (Gaussian distribution)
mu<-50
sig<-10
DD<-rnorm(n,mu,sig)

# setting (dimensions for range)
PP<-2
theta<-dim(PP)

# setting log-likelihood function (=loglike)
loglike<-function(theta){
  ll<-0
  for(i in 1:n){
    ll<-ll+log(dnorm(DD[i],theta[1],theta[2]))
  }
  return(ll)
}

# c(): Combine Values into a Vector or List
theta<-c(0.1,3.0)

# calculate log-likelihood function
loglike(theta)

#print(theta)

# maximum likelihood by L-BFGS-B method
res<-optim(theta,loglike,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,2.0),upper=c(Inf,Inf),control=list(fnscale=-1))
#fnscale=-1 : Get max value
print( summary(res) )

# AIC calculation
#print(res)
#res$par
#res$value
AIC<-(-2)*res$value+2*PP
print("AIC value")
print(AIC)
