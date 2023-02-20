# Basic2 No.3
# Maximum Likelihood for Linear Model

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

# linear regression model
fl<-lm(y~x)
#fl<-lm(y~x-1) # "-1" means no constant term
print( summary(fl) )

# nonlinear model
fm<-nls(y~a/(1+b*exp(-c*x)),start=c(a=75,b=10,c=0.1)) 
print( summary(fm) )

# plot (linear regression model)
windows()
par(mfcol=c(2,1))
plot(x,y)
a<-0.90283
b<-2.32344
curve(a*x+b,10,80) # show a linear regression model
points(x,y) # show data

# plot (nonlinear regression model)
windows()
par(mfcol=c(2,1))
plot(x,y)
a<-72.77627
b<-10.70953
c<-0.06435 
curve(a/(1+b*exp(-c*x)),10,80) # show a nonlinear regression model
points(x,y) # show data