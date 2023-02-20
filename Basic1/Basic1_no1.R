# Basic1 No.1

# settings (number of data)
n<-100

# setting (mean and sigma)
mu<-50
sig<-10
sig2<-sig^2

# Normal distribution (Gaussian distribution)
x<-dim(n)
x<-rnorm(n,mu,sig)

# plot
windows()
par(mfcol=c(3,1))
hist(x)
plot(density(x))
curve(dnorm(x,mu,sig),0,80)
#