data <- c(
	26.1, 25.8, 25.7, 27.2, 28.0,
	28.9, 26.8, 26.6, 27.2, 27.5,
	28.1, 27.0, 26.5, 26.7, 27.9,
	28.1, 27.3, 28.9, 27.3, 27.2)
data.mean <- mean(data)				# Calculate the average of the data 
data.sd <- sd(data)					# Standard deviation of data (find the square root of unbiased variance) 
n <- length(data)					# Get data points 

data.var <- var(data)				# Find unbiased variance 
chi.l <- qchisq(0.025,19)			# Find the cut point chi2 (19;0.025)
chi.u <- qchisq(0.975,19)			# Find the cut point chi2 (19;0.975)
var.lower <- (n-1)*data.var/chi.u	# Calculation of lower limit 
var.upper <- (n-1)*data.var/chi.l	# Calculation of upper limit 
cat("lower and upper limits=", var.lower, var.upper, "\n")
