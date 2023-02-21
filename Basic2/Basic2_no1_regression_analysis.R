# Basic2 No1
# regression analysis
# lm(): Regression analysis using linear model
# glm(): Regression analysis using general linear model
# lsfit(): Regression analysis using least squares method

# read *.csv file
DAT<-read.csv("data_Basic2_no1.csv")
print(DAT)

# correlation coefficient
print( cor(DAT$lot,DAT$price) )

# calculate
print("Regression model with some explanatory variables")
res1<-lm(price~lot+building,data=DAT)
print( summary(res1) )
#
print("Regression model with some explanatory variables and no constant term")
res2<-lm(price~lot+building+year-1,data=DAT) # "-1" means no constant term
print( summary(res2) )
#
print("Regression model with all explanatory variables")
res3<-lm(price~.,data=DAT)
print( summary(res3) )
#
print("Model selection using information criterion (AIC)")
res3_step<-step(res3)
print( summary(res3_step) )