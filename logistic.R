y <- c(27.7, 33.8, 46.5, 64.7, 87.0, 112.3, 254.4, 369.7, 428.0,
	436.1, 420.8, 412.1, 426.0, 447.8, 415.2, 416.8)				# Enter weight 
t <- c(0, 1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55)	# Enter the age of the moon 

# Logistic model
Logistic.result <- nls(y ~ A*(1+B*exp(-k*t))^-1,
	start=list(A=400, B=10, k=0.1))				# Nonlinear regression analysis and description of growth model. Input initial values for iterative estimation 
Logistic.predict <- predict(Logistic.result)	# Predicted value calculation 
or(Logistic.predict, y)^2	# Calculation of coefficient of determination 
AIC(Logistic.result)		# Calculation of AIC 
matplot(c(0,55), c(1,450), main="growth curve by Logistic model",
	xlab="the age of the moon", ylab="weight", type="n")	# Displaying the graph area 
points(Logistic.predict ~ t, type="1", col="blue")			# Display of predicted values 
points(y ~ t, pch="*")		# Display of measured values 
summary(Logistic.result)	# Display of analysis results 