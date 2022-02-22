data_mean <- numeric(length=10000)
for(i in 1:10000){
	data <- rnorm(n=100,mean=27.0,sd=1.1)
	data_mean[i] <- mean(data)
}
mean(data)
var(data)
hist(data,26,28)
