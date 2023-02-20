Breed  <- factor(c(1,2,2,1,2,2,1,1,2,2))	# Data entry (Breed) 
Parity <- factor(c(1,1,1,3,3,3,5,5,5,5))	# Data entry (Parity) 
Yield  <- c(5.0, 6.2, 6.4, 6.6, 6.4, 7.3, 6.7, 7.2, 7.8, 7.9)	# Data entry (Yield) 
Yield.data <- data.frame(breed=Breed, parity=Parity, rhs=Yield)	# Create a data frame 
anova.result <- aov(rhs ~ breed+parity, data=Yield.data)		# Perform ANOVA 
summary(anova.result)			# Output of ANOVA table 
lsmean <- coef(anova.result)	# Calculation of least squares estimate 
lsmean							# Output of least squares estimate 
parity.diff <- TukeyHSD(anova.result, "parity")	# Tukey's HSD method multiple comparison 
parity.diff						# Multiple comparison result output 