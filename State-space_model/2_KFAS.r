# Analysis by "KFAS"

## Using "KFAS" package and "Seatbelts" data
library(KFAS)
data(Seatbelts)

## Model definition
model.van <- SSModel(VanKilled ~ law +
  SSMtrend(degree = 1, Q = list(matrix(NA))) +
  SSMseasonal(period = 12, sea.type = "dummy", Q = matrix(NA)), 
  data = Seatbelts, distribution = "poisson")
fit.van <- fitSSM(model = model.van, inits = c(0, 0))

## Show Q
print(fit.van$model$Q)

## Apply Kalman smoother and extract signal
out.van <- KFS(fit.van$model, smoothing = c("state"))
sig.van <- signal(out.van, states = c("trend", "regression"))
season.van <- signal(out.van, states = c("seasonal"))
reg.van <- signal(out.van, states = c("regression"))

## View graph
library(ggplot2)
d <- data.frame(Year = seq(start(Seatbelts)[1],
  end(Seatbelts)[1] + 11/12, 1 / 12),
  VanKilled = c(Seatbelts[, "VanKilled"]),
  Smooth = exp(c(sig.van$signal)),
  Seasonal = c(season.van$signal),
  Regression = c(reg.van$signal))
p <- ggplot(d)
p + geom_point(aes(x = Year, y = VanKilled)) +
  geom_line(aes(x = Year, y = VanKilled)) +
  geom_line(aes(x = Year, y = Smooth),
  colour = "gray35", size = 1.2) +
  ylab("No. of van drivers") +
  theme_classic(12, "Helvetica")

## Show condition of seasonally adjusted and regression components
p + geom_line(aes(x = Year, y = Seasonal)) +
  geom_line(aes(x = Year, y = Regression), linetype = 2) +
  ylab("State") + theme_classic(12, "Helvetica")

## Model without "law" variable
model.van2 <- SSModel(VanKilled ~ 
  SSMtrend(degree = 1,Q = list(matrix(NA))) +
  SSMseasonal(period = 12, sea.type = "dummy",Q = matrix(NA)),
  data = Seatbelts, distribution = "poisson")
fit.van2 <- fitSSM(model = model.van2, inits = c(0, 0))

## Likelihood ratio test (result not significant)
diff.2logLik <- 2 * (logLik(fit.van$model) - logLik(fit.van2$model))
print(1 - pchisq(diff.2logLik, df = 1))