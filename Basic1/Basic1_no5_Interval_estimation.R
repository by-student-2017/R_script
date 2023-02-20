# Basic1 No.5
# Interval estimation

# select data
# (1:make random data, 2: read *.dat file)
SW<-2

# make random data
if(SW==1){
  n<-18
  mu<-50
  sig<-10
  D<-rnorm(n,mu,sig)
}
# read *.dat from "C:\Users\username\Documents"
if(SW==2){
  D<-matrix(scan("data_Basic1_no5.dat"),ncol=1,byrow=TRUE)
  #  default pass: "C:\\Users\\username\\Documents\data_Basic1_no5.dat"
  #D<-matrix(scan("C:\\Users\\username\\Desktop\\data_Basic1_no5.dat"),ncol=1,byrow=TRUE)
  n<-length(D)
  print(n)
}

# estimated mean and unbiased variance
es_mu<-mean(D)
es_sig2<-var(D)

# plot
# t-distribution with (n-1) degrees of freedom
print("Interval estimate of the mean 95%")
print( es_mu-qt(0.975,n-1)*sqrt(es_sig2/n) )
print( es_mu+qt(0.975,n-1)*sqrt(es_sig2/n) )
#
# chi-square distribution with (n-1) degrees of freedom
print("Interval estimation of variance 95%")
print( (n-1)*es_sig2/qchisq(0.975,n-1) )
print( (n-1)*es_sig2/qchisq(0.025,n-1) )