data{
  int N;
  real Y[N];
  real Z_m[N];
  real ZZ_1[N];
  real ZZ_2[N];
  real ZZ_3[N];
}

parameters{
  real<lower=0> a1;
  real p1;
  real p2;
  real p3;
  real<lower=0> a2;
  real b;
  real <lower=0> eta[N];
  real <lower=0> m[N];
}

model{
  for(i in 1:N){
    eta[i] ~ gamma(a1,exp(-(p1*ZZ_1[i]+p2*ZZ_2[i]+p3*ZZ_3[i])));
    m[i] ~ gamma(a2,b*Z_m[i]);
    Y[i] ~ weibull(m[i],eta[i]);
  }
  a1 ~ uniform(0,10);
  p1 ~ normal(0,10);
  p2 ~ normal(0,10);
  p3 ~ normal(0,10);
  a2 ~ uniform(0,10);
  b ~ normal(0,10);
}

