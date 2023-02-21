data{
  int N;
  real X[N];
}

parameters{
  real<lower=0> m;
  real<lower=0> eta;
}

model{
  for(i in 1:N){
    X[i] ~ weibull(m,eta);
  }
  m ~ uniform(0,10);
  eta ~ uniform(0,1000);
}

