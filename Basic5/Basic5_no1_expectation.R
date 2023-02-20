# Basic5 No.1
# Expectation (Importance Sampling)

# settings (number of data)
#N<-1000
N<-1000000

# generate random data
x<-rnorm(N,0,1)

# calculate "sum(exp(-(x^2/2)))/N"
ss<-0; sx<-0
for(i in 1:N){
  ss<-ss+exp(-(x[i]^2/2))
  sx<-sx+x[i]
}
ex<-ss/N
mx<-sx/N

# plot
print("sum(exp(-(x^2/2)))/N: ideal value is 1/sqrt(1+1)=0.707106781")
print(ex)
print("using sum function")
print( sum(exp(-(x^2/2)))/N )

# plot
print("mean(X): ideal value is 0.0")
print(mx)
print("using sum function")
print( sum(x)/N )

#------------------------------------
# 

# settings (number of data)
N<-10000

# setting (parameter)
x<-5.0

# Generate discrete uniform distributed random numbers
lam<-runif(N,0,10)

# plot
print("sum(lam*exp(-lam*x)*dgamma(lam,1,2)/(1/10))/N")
print( sum(lam*exp(-lam*x)*dgamma(lam,1,2)/(1/10))/N )

#------------------------------------
# Mixture Distribution

# settings (number of data)
N<-500

# setting (parameters)
q1<-0.6
q2<-0.4
#-------
N1<-q1*N
N2<-q2*N
#-------
mu1<-50
sig1<-10
#-------
mu2<-80
sig2<-3

# generate random data from Normal distribution (Gauss distribution)
x1<-rnorm(N1,mu1,sig1)
x2<-rnorm(N2,mu2,sig2)

# c(): Combine Values into a Vector or List
x<-c(x1,x2)

# plot
par(mfcol=c(3,1))
hist(x)
plot(density(x))
curve(q1*dnorm(x,mu1,sig1)+q2*dnorm(x,mu2,sig2),0,100)