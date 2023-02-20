x1 <- c(1.27, 1.28, 1.31, 1.28, 1.32, 1.27, 1.28, 1.27, 1.28)	# Store data in vector 
x2 <- c(1.45, 1.50, 1.50, 1.52, 1.50, 1.46, 1.53, 1.50, 1.47)
x3 <- c(1.80, 1.86, 1.98, 1.96, 1.87, 1.86, 1.84, 1.82, 1.92)
y  <- c(475, 490, 580, 557, 540, 440, 459, 470, 500)
mreg <- data.frame(Height=x1, Length=x2, Chest=x3, Weight=y)	# Create a data frame 
mreg.result <- lm(Weight ~ Height+Length+Chest, data=mreg)		# Performing multiple regression analysis 
summary(mreg.result)	# View results 
anova(mreg.result)		# Display of ANOVA table 