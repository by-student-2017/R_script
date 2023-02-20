# Basic2 No.1
# maximum likelihood
# Maximize log-likelihood function

# read *.csv file
DAT<-read.csv("data_Basic2_no1.csv")
print(DAT)

# settings from *.csv
x<-DAT$lot
y<-DAT$price

# show dimension of y
n<-length(y)
print("dimention of y")
print(n)

# setting (dimensions for range)
PP<-3 ” number of parameters
theta<-dim(PP) ” parameters to estimate (vector)

# maximum likelihood estimation
llf<-function(theta){
  ll<-0
  for(i in 1:n){
    ll1<-(-0.5)*log(2*pi*theta[3]^2)
     mu<-theta[1]*x[i]+theta[2]
    ll2<-(-1)*(y[i]-mu)^2/(2*theta[3]^2)
     ll<-ll+(ll1+ll2)
  }
  return(ll)
}

# c(): Combine Values into a Vector or List
theta<-c(0.5,0.5,1.0) # setting initial value

# value obtained by substituting the initial value into the log-likelihood function
llf(theta)

#print(theta)

# maximum likelihood by L-BFGS-B method
res<-optim(theta,llf,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,-Inf,0),upper=c(Inf,Inf,Inf),control=list(fnscale=-1))
#fnscale=-1 : Get max value
print( summary(res) )

# find the parameters of the same model with the least squares method
fl<-lm(y~x)
print( summary(fl) )