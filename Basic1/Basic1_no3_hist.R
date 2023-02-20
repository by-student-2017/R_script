# Basic1 No.3

# settings (number of data)
n<-30

# settings (number of cycles (for loop))
N<-100

# settings (dimensions)
D<-dim(n)
P_MU<-dim(N)
P_SIG<-dim(N)

# setting (mean and sigma)
mu<-50
sigma<-15

# calculation
for(i in 1:N){
  D<-rnorm(n,mu,sigma)
  P_MU[i]<-mean(D)
  P_SIG[i]<-var(D)
}

# show results
print("P_MU")
print(P_MU)
print("P_SIG")
print(P_SIG)
#
hist(P_MU)
hist(P_SIG)