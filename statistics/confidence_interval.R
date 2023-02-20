mu <- 100							# population mean
sigma2 <- 9							# population variance
sigma <- sqrt(sigma2)
n <- 100							# sample size
alfa_half <- 0.025					# Cumulative density 1-a/2 = 0.975
z.value <- qnorm(1-alfa_half)		# Cut point value 
z.range <- z.value*sigma/sqrt(n)

n.rep <- 100						# Number of sampling iterations 
ave <- numeric(n.rep)				# Vector of sample mean 
lower <- numeric(n.rep)				# Lower limit vector 
upper <- numeric(n.rep)				# Upper limit vector
flag <- numeric(n.rep)				# Flags (out of range)
color <- c("black","red")

for(i in 1:n.rep){
	ave[i] <- mean(rnorm(n,mean=mu,sd=sigma))			# Calculation of sample mean using random numbers 
	lower[i] <- ave[i] - z.range						# Calculation of lower limit 
	upper[i] <- ave[i] + z.range						# Calculation of upper limit 
	if((lower[i]>mu)||(upper[i]<mu)){					# Determine if the population mean is included in the confidence interval 
		cat("Do not include population mean",i,"\n")
		flag[i] = 1
	}
}

x.axis <- 1:n.rep
plot(x.axis,ave,ylim=c(98,102),xlab="number of sample",ylab="mean +/- confidence interval",pch=19,col=color[flag+1])
abline(100,0)
for(i in 1:n.rep){
	segments(i,ave[i],i,upper[i],col=color[flag[i]+1])	# Show the upper limit of the confidence interval
	segments(i,ave[i],i,lower[i],col=color[flag[i]+1])	# Show the lower limit of the confidence interval
}