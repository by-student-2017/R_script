data{
  int Y; // The number of correct answers
  int T; // Number of trials
}

parameters{
  // You want to know parameter theta
  real<lower=0, upper=1> theta;
}

model{
  // Uniform distribution from 0 to 1 (non-informative prior distribution)
  theta ~ uniform(0,1);
  // Follow the binomial distribution
  Y ~ binominal(T, theta);
}

generated quantities{
  int y_pred;
  y_pred = binominal_rng(T,theta)
}
