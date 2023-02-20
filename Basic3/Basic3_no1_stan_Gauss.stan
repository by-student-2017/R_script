data{
  int N;
  real X[N];
}

parameters{
  real mu;
  real<lower=0> sigma;
}

model{
  for(i in 1:N){
    X[i] ~ normal(mu,sigma);
  }
  mu ~ normal(0,100);
  sigma ~ uniform(0,1000);
}

