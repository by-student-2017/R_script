# Basic1 No.6
# t-test

# Normal distribution (Gauss distribution)
x<-rnorm(10,50,10)
y<-rnorm(15,50,10)

# calculate mean
print( mean(x) )
print( mean(y) )

# One Sample t-test
print( t.test(x,mu=50) )

# Two Sample t-test
print( t.test(x,y,var.equal=TRUE) )

# F test to compare two variances
print( var.test(x,y) )