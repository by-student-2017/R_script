# Basic1 No.2

# Normal distribution (Gauss distribution)
#rnorm(N,50,10) # random value
#dnorm(x,50,10) # probability density function
#pnorm(x,50,10) # Cumulative distribution function
#qnorm(p,50,10) # percentile value

# calculation
rnorm(100,50,10)
curve(dnorm(x,50,10),from=0,to=100)
#pnorm(50,50,10)
#qnorm(0.5,50,10)