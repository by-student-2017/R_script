Sex <- factor(c("M","M","F","F","M","M",
	"F", "F", "M", "M", "F", "F"))
Diet <- factor(c("A1", "A1", "A1", "A1", "A2", "A2",
	"A2", "A2", "A3", "A3", "A3", "A3"))
Weight <- c(30, 29, 23, 22, 31, 28, 26, 27, 38, 36, 36, 35)
Weight.data <- data.frame(sex=Sex,diet=Diet,rhs=Weight)			# Creating a data frame 
anova.result <- aov(rhs ~ diet+sex+diet*sex,data=Weight.data)	# Performing ANOVA 
summary(anova.result)			# Output of ANOVA table 
lsmean <- coef(anova.result)	# Calculation of least squares estimate 
lsmean							# Output of least squares estimate
diff.result <- TukeyHSD(anova.result)	# Display of test results by Tukey's HSD method 
diff.result								# Output of multiple comparison test results 