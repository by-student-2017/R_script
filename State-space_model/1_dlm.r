# Analysis by "dlm"

## Analysis using "dlm" package and "Nile" data
library(dlm)
data(Nile)

## Definition of Build function
BuildLLM <- function(theta) {
  dlmModPoly(order = 1,
  dV = theta[1], dW = theta[2],
  m0 = 0, C0 = 1e+7)
}

## Maximum likelihood estimation
fit.llm <- dlmMLE(Nile, build = BuildLLM,
  parm = c(100, 2), lower = rep(1e-4, 2))

## Show estimated values
print(fit.llm$par)

## Use estimated parameters in Build function
model.llm <- BuildLLM(fit.llm$par)

## Smoothing
smooth.llm <- dlmSmooth(y = Nile, mod = model.llm)

## Show graph
library(ggplot2)
p <- ggplot(data.frame(Year = start(Nile)[1]:end(Nile)[1],
  Flow = c(Nile), Smooth = smooth.llm$s[-1]))
p + geom_point(aes(x = Year, y = Flow)) +
  geom_line(aes(x = Year, y = Flow)) + 
  geom_line(aes(x = Year, y = Smooth),
  colour = "gray35", linetype = 1, size = 1.2) + 
  ylab(expression(paste("Flow (", 10^8, m^3, ")"))) + 
  theme_classic(12, "Helvetica")
