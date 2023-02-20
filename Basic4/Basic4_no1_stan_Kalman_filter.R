# Basic4 No.1
# Kalman filter

# settings (number of data)
N<-1000

# settings (dimensions)
x<-dim(N)
y<-dim(N)
#--------
a<-dim(N)
R<-dim(N)
f<-dim(N)
Q<-dim(N)
K<-dim(N)
#--------
m<-dim(N)
C<-dim(N)

# settings (parameters for simulation data)
G<-0.6
#--------
Sig<-0.5
Sig2<-Sig^2
#--------
F<-0.8
#--------
Del<-1.0
Del2<-Del^2

# generate random data
x[1]<-0.5
y[1]<-G*x[1]+rnorm(1,0,Del)
#--------
for(i in 2:N){
  x[i]<-G*x[i-1]+rnorm(1,0,Sig)
  y[i]<-F*x[i]+rnorm(1,0,Del)
}

# plot
windows()
par(mfcol=c(3,1))
plot(x,type="l")
plot(y,type="l")

#-----Filtering-----

# settings (initial data)
m[1]<-0.5
C[1]<-1.0
#------
a[1]<-0
R[1]<-0
f[1]<-0
Q[1]<-0
K[1]<-0

# generate simulation data
for(i in 2:N){
  a[i]<-G*m[i-1]
  R[i]<-G*C[i-1]*G+Sig2
  #
  f[i]<-F*a[i]
  Q[i]<-F*R[i]*F+Del2
  #
  K[i]<-R[i]*F/Q[i]
  #
  m[i]<-a[i]+K[i]*(y[i]-f[i])
  C[i]<-(1-K[i]*F)*R[i]
}

# plot
plot(m,type="l")

# setting (dimension)
theta<-dim(2)

# Kalman filter
llg<-function(theta){
  F<-theta[1]
  G<-theta[2] 
  Del2<-1.0
  Sig2<-0.25
  #
  ll1<-0
  ll2<-0
  #
  for(i in 2:N){
    a[i]<-G*m[i-1]
    R[i]<-G*C[i-1]*G+Sig2
    #
    f[i]<-F*a[i]
    Q[i]<-F*R[i]*F+Del2
    #
    K[i]<-R[i]*F/Q[i]
    #
    m[i]<-a[i]+K[i]*(y[i]-f[i])
    C[i]<-(1-K[i]*F)*R[i]
    #
    ll1<-(-1/2)*log(abs(Q[i]))+ll1
    ll2<-(-1/2)*(y[i]-f[i])^2/Q[i]+ll2     
  }
  ll<-ll2+ll1
  return(ll)
}

# initial value
theta[1]<-0.1
theta[2]<-0.1

# value obtained by substituting the initial value into the Kalman filter
llg(theta)

# Kalman filter by L-BFGS-B method
res<-optim(theta,llg,method="L-BFGS-B",hessian=TRUE,lower=c(-1,-1),upper=c(1,1),control=list(fnscale=-1))
#fnscale=-1 : get max value
print( summary(res) )
