data{
 int N;
 real Y[N];
}

parameters{
  real<lower=-1,upper=1> a;
  real<lower=0> b;
  real mu;
  real R[N];
}

model{
  R[1] ~ normal(mu,b/sqrt(1-a*a));
  for(i in 2:N){
    R[i] ~ normal(mu+a*(R[i-1]-mu),b);
    Y[i] ~ normal(0,exp(R[i]/2));  
  }
  a ~ normal(0,1.0);
  b ~ normal(0,1.0);
  mu~ cauchy(0,2.0);
}
