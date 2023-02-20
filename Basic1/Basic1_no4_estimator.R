# Basic1 No.4
# Estimator (Mean and Variance)
# t value for mean: Student's t-distribution
# Variance, W: chi-square distribution
#  Zn=(Xn - mu)/sigma, V=Z1^2+Z2^2+...+Zn^2

# settings (number of data)
n<-30

# settings (number of cycles (for loop))
N<-10000

# settings (dimensions)
D<-dim(n)
P_MU<-dim(N)
P_VAR<-dim(N)
#----------
t<-dim(N)
W<-dim(N)
#----------

# setting (mean and sigma)
mu<-50
sigma<-15

# calculation
for(i in 1:N){
  D<-rnorm(n,mu,sigma)
  P_MU[i]<-mean(D)
  P_VAR[i]<-var(D) # sample unbiased variance
  #--------------------------------------
      # Student's t-distribution
      t[i]<-(P_MU[i]-mu)/sqrt(P_VAR[i]/n)
      
      # chi-square distribution
      # W*sigma^2 = (n-1)*s^2
      W[i]<-((n-1)*P_VAR[i])/sigma^2
  #--------------------------------------
}

# show results
print("P_MU")
print(P_MU)
print("P_VAR")
print(P_VAR)
#
hist(P_MU)
hist(P_VAR)
#
windows()
par(mfcol=c(2,1))
hist(t)
plot(density(t))
#
windows()
par(mfcol=c(2,1))
hist(W)
plot(density(W))
#