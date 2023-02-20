# Basic2 No.3
# least squares method

# read *.dat
data<-matrix(scan("data_Basic2_no3.dat"),ncol=2,byrow=TRUE)
print(data)

# settings from *.dat
y<-data[,1]
x<-data[,2]

# show dimension of y
n<-length(y)
print("dimention of y")
print(n)

# linear regression model (lm)
fl<-lm(y~x)
print( summary(fl) )

# setting (dimensions for range)
PP<-2 # number of parameters
theta<-dim(PP) # parameters to estimate (vector)

# setting least squares function (=lsm)
lsm<-function(theta){
  ll<-0
  for(i in 1:n){
    ll<-ll+(y[i]-theta[1]*x[i]-theta[2])^2
  }
  return(ll)
}

# c(): Combine Values into a Vector or List
theta<-c(-100,100) # setting initial value

# calculate least squares function
lsm(theta)

#print(theta)

# least squares function by L-BFGS-B method
res<-optim(theta,lsm,method="L-BFGS-B",hessian=TRUE,lower=c(-Inf,-Inf),upper=c(Inf,Inf),control=list(fnscale=1))
#fnscale=1 : Get max value
print( summary(res) )

# AIC calculation
#print(res)
#res$par
#res$value
AIC<-(-2)*res$value+2*PP
print("AIC value")
print(AIC)