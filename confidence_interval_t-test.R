data <- c(
	26.1, 25.8, 25.7, 27.2, 28.0,
	28.9, 26.8, 26.6, 27.2, 27.5,
	28.1, 27.0, 26.5, 26.7, 27.9,
	28.1, 27.3, 28.9, 27.3, 27.2)
data.mean <- mean(data)				# Calculate the average of the data 
data.sd <- sd(data)					# Standard deviation of data (find the square root of unbiased variance) 
n <- length(data)					# Get data points 

t.alpha <- qt(0.975,19)				# Find the cut point t (19; 0.975) 
mu.lower <- data.mean - t.alpha*data.sd/sqrt(n)	# Calculation of lower limit 
mu.upper <- data.mean + t.alpha*data.sd/sqrt(n)	# Calculation of upper limit 
cat("mean and sd", data.mean, data.sd, "\n")
cat("lower and upper limits=", mu.lower, mu.upper, "\n")
